Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAAF337115
	for <lists+bpf@lfdr.de>; Thu, 11 Mar 2021 12:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhCKLXs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Mar 2021 06:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbhCKLXd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Mar 2021 06:23:33 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A58C061574
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 03:23:32 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id f26so1658514ljp.8
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 03:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2v+Arevb1Ak0t5KWg5BkxG8jHrToZPIBxvbuImtLMmY=;
        b=ckvYMj05H7YeuEQii+I4v37xMJTWlsosZUe6sXFWnq17PJp1XY0Poc8tp2W/PXL+G4
         NJ4JJRPvsurPlbCAdifRvsTWSHV+3zi5vTFge9us2MFsea7cTQaIexvS7uwlaepHSdjb
         mmueR/kWONYyNyaZSOHW/QrKpoW7AbfOrNDSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2v+Arevb1Ak0t5KWg5BkxG8jHrToZPIBxvbuImtLMmY=;
        b=quMLJK31T1aGtU/ZPITJjtf32tOIIU/lG9J1KdVWANJ/xcmemW67UATQDphTtvlXjc
         d6D4DzS6HlrcrwP4u1/1MqSLPTOal0+KyxlW5P4G07PY4zXI5Rgyt7SJT3jh7K6qMSxT
         bU2MuwWfSP8dgiisEyQeA1bEt6mzgD1NpBXKPkA+oBU8ASD0/q7KhP/UJhs0PUDJcVqm
         n9t0Z43ws0i8trBchFl6oSh77vXJrpMdR6kcf8SkI1rA+SfJXJNDLVUO0bXT8cu/y/Ix
         ajUXf/2eb8BksTgySps8AIjH14Rx6v9QanKydNPnaiAmiMaBu9r8DhGb0LenyWhMHBEv
         pB5w==
X-Gm-Message-State: AOAM533/PNkqWl3SvThl0Cq0okQCeoms65QtxaDaoeCLlXlN7eAhJeJq
        VXqogaf2yZRLINA5QweYYx0+do/4I3zxp5pL7Kn2BZ1B7Z5auw==
X-Google-Smtp-Source: ABdhPJx+ZYVMtv/SxJs2GmbghQHZ9urlkXQAKbQDIPicX7rZlmO9mUH5Wu3XBKMKxFen5A6MoDAlDiYGEC6bkuWhnmM=
X-Received: by 2002:a2e:9310:: with SMTP id e16mr4652975ljh.226.1615461811277;
 Thu, 11 Mar 2021 03:23:31 -0800 (PST)
MIME-Version: 1.0
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 11 Mar 2021 11:23:20 +0000
Message-ID: <CACAyw9-eYh7sJ_86bS4dDZ52Uf3nY7-=pHhFr42cqXwMj5tmDQ@mail.gmail.com>
Subject: clang-9 and clang-10 BTF miscompilation
To:     Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Yonghong, Andrii,

Given the following C source:

typedef struct {
    unsigned char thing[36];
} foo_t;

struct {
    __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
    __uint(key_size, sizeof(unsigned int));
    __uint(max_entries, 1);
    __array(
        values, struct {
            __uint(type, BPF_MAP_TYPE_HASH);
            __uint(max_entries, 1);
            __type(key, unsigned int);
            __type(value, foo_t);
        });
} btf_map __section(".maps");

__section("socket") int filter() {
    unsigned int key = 0;
    void *value      = bpf_map_lookup_elem(&btf_map, (void *)&key);
    if (value)
        return *(int *)value;
    return 0;
}

I get this BTF from clang-9 and clang-10:

[1] STRUCT '(anon)' size=24 vlen=4
    'type' type_id=2 bits_offset=0
    'key_size' type_id=6 bits_offset=64
    'max_entries' type_id=8 bits_offset=128
    'values' type_id=16 bits_offset=192
[2] PTR '(anon)' type_id=4
[3] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[4] ARRAY '(anon)' type_id=3 index_type_id=5 nr_elems=12
[5] INT '__ARRAY_SIZE_TYPE__' size=4 bits_offset=0 nr_bits=32 encoding=(none)
[6] PTR '(anon)' type_id=7
[7] ARRAY '(anon)' type_id=3 index_type_id=5 nr_elems=4
[8] PTR '(anon)' type_id=9
[9] ARRAY '(anon)' type_id=3 index_type_id=5 nr_elems=1
[10] PTR '(anon)' type_id=11
[11] STRUCT '(anon)' size=32 vlen=4
    'type' type_id=8 bits_offset=0
    'max_entries' type_id=8 bits_offset=64
    'key' type_id=12 bits_offset=128
    'value' type_id=14 bits_offset=192
[12] PTR '(anon)' type_id=13
[13] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
[14] PTR '(anon)' type_id=15
[15] TYPEDEF 'foo_t' type_id=1
[16] ARRAY '(anon)' type_id=10 index_type_id=5 nr_elems=0
[17] VAR 'btf_map' type_id=1, linkage=global-alloc
[18] FUNC_PROTO '(anon)' ret_type_id=3 vlen=0
[19] FUNC 'filter' type_id=18
[20] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
[21] ARRAY '(anon)' type_id=20 index_type_id=5 nr_elems=4
[22] VAR '__license' type_id=21, linkage=global-alloc
[23] DATASEC '.maps' size=0 vlen=1
    type_id=17 offset=0 size=24
[24] DATASEC 'license' size=0 vlen=1
    type_id=22 offset=0 size=4

Note that [15] TYPEDEF 'foo_t' type_id=1 resolves to type 1, which is a
BTF map definition. Clang-11 seems to fix this, so maybe you are already aware.

Best
Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
