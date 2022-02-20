Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E61A4BCD01
	for <lists+bpf@lfdr.de>; Sun, 20 Feb 2022 08:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbiBTHN6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Feb 2022 02:13:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbiBTHN5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Feb 2022 02:13:57 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1952E506F7
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 23:13:37 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id w37so5156152pga.7
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 23:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=HzyfQhtW3xj8FHWDnDYb5y9zrFWfhcbA6KWHTQp4XuI=;
        b=UR0fbNFu/QRrS0JGWvHcYRFmBb1z2oxySSPtqTyAPDlheYUNfcYufPJm8mYxeUzXSL
         BpzQ5FrddEXB/BLQ1kEZHK0BeGoQCPUULpjfI+l1cju6zfb2eaUfUBeTfEEpblt75/rd
         Jok8XfzacM4M3JYHyu1mjEBynEOtlOQ5V8+pV/R4Tpl73zZZ1AnGS/P34I8EC+E9DFC8
         m1wfGthHvMVGEsfdkAtPJ2Ud56x80+gYzTqTd3ScLZW2gV3oa2GRm/BdYDeCpnPHpeWw
         TRMp+ANData6Jr3yHvM5v5DIii4j3toiF5yNV3RIEzl+OuJJsFji/9d2Gy6vevIGk5qJ
         jLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HzyfQhtW3xj8FHWDnDYb5y9zrFWfhcbA6KWHTQp4XuI=;
        b=2Q5wNlDsOCUU8w5APLAU7DpPc53cvDhr6JPe/9Gmeu9wn0nf0ReWjTQiv0nYaeuyh4
         dodn3PvQUoPBHwLyG7ykhC40+WUS3YmlO7TeTsiLWVHhV9tubmLO0ixiNpwZJO4vV1M3
         cqRKB+CDaWcv6910Y0V4Yz56HHeG1Fh2TeFy0gB87gkSpbxD6vxmhdpJUx/KD8BKV6TM
         I9uMvfiejN5NNg8HCWUa4p8vbtfTShrSleKcVWYaTzl+LzgZv/VpnNK6npf2OR1NZHvP
         CDBJqZLIY6Vy1jgQV6R0gezT7E8JcEUz8mfyY8azvTNwz9Tmb3FAWzRif6OwCCEVFcTL
         lMKA==
X-Gm-Message-State: AOAM5316lYA/1gkKfzmBwJzb++/8B7CbatiicpjxxMlTo4HP9psBbyMr
        5uFfd5PURYWznNTp8AjeITyzd8JVoP0=
X-Google-Smtp-Source: ABdhPJxs7h8Ir0F5XEApov4K6sFfPl6SPWZPlUQNX7Pdj9ffzpI1t6tmKCreD5/lMIu7fnsOmvfv0Q==
X-Received: by 2002:a63:445f:0:b0:373:d43f:2b42 with SMTP id t31-20020a63445f000000b00373d43f2b42mr8405357pgk.125.1645341216201;
        Sat, 19 Feb 2022 23:13:36 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id ch16-20020a17090af41000b001bb76670ff7sm3811667pjb.45.2022.02.19.23.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 23:13:35 -0800 (PST)
Date:   Sun, 20 Feb 2022 12:43:33 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>
Subject: BTF type tags not emitted properly when using macros
Message-ID: <20220220071333.sltv4jrwniool2qy@apollo.legion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi list,

I noticed another problem in LLVM HEAD wrt BTF type tags.

When I have a file like bad.c:

 ; cat bad.c
#define __kptr __attribute__((btf_type_tag("btf_id")))
#define __kptr_ref __kptr __attribute__((btf_type_tag("ref")))
#define __kptr_percpu __kptr __attribute__((btf_type_tag("percpu")))
#define __kptr_user __kptr __attribute__((btf_type_tag("user")))

struct map_value {
        int __kptr *a;
        int __kptr_ref *b;
        int __kptr_percpu *c;
        int __kptr_user *d;
};

struct map_value *func(void);

int main(void)
{
        struct map_value *p = func();
        return *p->a + *p->b + *p->c + *p->d;
}

All tags are not emitted to BTF (neither are they there in llvm-dwarfdump output):

 ; ./src/linux/kptr-map/tools/bpf/bpftool/bpftool btf dump file bad.o format raw
[1] FUNC_PROTO '(anon)' ret_type_id=2 vlen=0
[2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[3] FUNC 'main' type_id=1 linkage=global
[4] FUNC_PROTO '(anon)' ret_type_id=5 vlen=0
[5] PTR '(anon)' type_id=6
[6] STRUCT 'map_value' size=32 vlen=4
        'a' type_id=8 bits_offset=0
        'b' type_id=11 bits_offset=64
        'c' type_id=11 bits_offset=128
        'd' type_id=11 bits_offset=192
[7] TYPE_TAG 'btf_id' type_id=2
[8] PTR '(anon)' type_id=7
[9] TYPE_TAG 'btf_id' type_id=2
[10] TYPE_TAG 'ref' type_id=9
[11] PTR '(anon)' type_id=10
[12] FUNC 'func' type_id=4 linkage=extern

Notice that only btf_id (__kptr) and btf_id + ref (__kptr_ref) are emitted
properly, and then rest of members use type_id=11, instead of emitting more type
tags.

When I use a mix of macro and direct attributes, or just attributes, it does work:

; cat good.c
#define __kptr __attribute__((btf_type_tag("btf_id")))

struct map_value {
        int __kptr *a;
        int __kptr __attribute__((btf_type_tag("ref"))) *b;
        int __kptr __attribute__((btf_type_tag("percpu"))) *c;
        int __kptr __attribute__((btf_type_tag("user"))) *d;
};

struct map_value *func(void);

int main(void)
{
        struct map_value *p = func();
        return *p->a + *p->b + *p->c + *p->d;
}

Now all tags are there in BTF:

 ; ./src/linux/kptr-map/tools/bpf/bpftool/bpftool btf dump file good.o format raw
[1] FUNC_PROTO '(anon)' ret_type_id=2 vlen=0
[2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[3] FUNC 'main' type_id=1 linkage=global
[4] FUNC_PROTO '(anon)' ret_type_id=5 vlen=0
[5] PTR '(anon)' type_id=6
[6] STRUCT 'map_value' size=32 vlen=4
        'a' type_id=8 bits_offset=0
        'b' type_id=11 bits_offset=64
        'c' type_id=14 bits_offset=128
        'd' type_id=17 bits_offset=192
[7] TYPE_TAG 'btf_id' type_id=2
[8] PTR '(anon)' type_id=7
[9] TYPE_TAG 'btf_id' type_id=2
[10] TYPE_TAG 'ref' type_id=9
[11] PTR '(anon)' type_id=10
[12] TYPE_TAG 'btf_id' type_id=2
[13] TYPE_TAG 'percpu' type_id=12
[14] PTR '(anon)' type_id=13
[15] TYPE_TAG 'btf_id' type_id=2
[16] TYPE_TAG 'user' type_id=15
[17] PTR '(anon)' type_id=16
[18] FUNC 'func' type_id=4 linkage=extern

In both cases, the preprocessed source (using -E) looks to be the same:

 ; /home/kkd/src/llvm-project/llvm/build/bin/clang --target=bpf -g -O2 -c bad.c -E
# 1 "bad.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 323 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "bad.c" 2

struct map_value {
 int __attribute__((btf_type_tag("btf_id"))) *a;
 int __attribute__((btf_type_tag("btf_id"))) __attribute__((btf_type_tag("ref"))) *b;
 int __attribute__((btf_type_tag("btf_id"))) __attribute__((btf_type_tag("percpu"))) *c;
 int __attribute__((btf_type_tag("btf_id"))) __attribute__((btf_type_tag("user"))) *d;
};

struct map_value *func(void);

int main(void)
{
 struct map_value *p = func();
 return *p->a + *p->b + *p->c + *p->d;
}

 ; /home/kkd/src/llvm-project/llvm/build/bin/clang --target=bpf -g -O2 -c good.c -E
# 1 "good.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 323 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "good.c" 2

struct map_value {
 int __attribute__((btf_type_tag("btf_id"))) *a;
 int __attribute__((btf_type_tag("btf_id"))) __attribute__((btf_type_tag("ref"))) *b;
 int __attribute__((btf_type_tag("btf_id"))) __attribute__((btf_type_tag("percpu"))) *c;
 int __attribute__((btf_type_tag("btf_id"))) __attribute__((btf_type_tag("user"))) *d;
};

struct map_value *func(void);

int main(void)
{
 struct map_value *p = func();
 return *p->a + *p->b + *p->c + *p->d;
}

--

Please let me know if I made some dumb mistake.

 ; /home/kkd/src/llvm-project/llvm/build/bin/clang --version
clang version 15.0.0 (https://github.com/llvm/llvm-project.git 290e482342826ee4c65bd6d2aece25736d3f0c7b)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /home/kkd/src/llvm-project/llvm/build/bin

A side note, but it seems it could avoid emitting the same type tag multiple
times to save on space. I.e. in the case of other members, their ref, percpu,
user tag could point to the same btf_id type tag that the first member's
BTF_KIND_PTR points to.

Thanks.
--
Kartikeya
