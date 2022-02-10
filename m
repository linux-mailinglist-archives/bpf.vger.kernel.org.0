Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C027E4B1967
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 00:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238384AbiBJXYQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 18:24:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345626AbiBJXYO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 18:24:14 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498285F59
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 15:24:15 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id on2so6534136pjb.4
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 15:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=u2FMbX0qnOvvgCDfzy715jd1Xj6Ekn6z7RRaJuXviOo=;
        b=p3cjzUimZBYC3KcyG//Y+ukAItsmfng+Jxocd4cJI0zo13daqCp4hGbb54K6eMh/XZ
         HNEfvxGYPU2me6P/0zThxsjEdwLd/r5wOPzNMjqO4iC4VD8vSTqNuk3t0I+SRDUrAFay
         YW5MlhGP4yggjHiyJaL77mCgF33Q3nC/J0L8Kbc2T0XmAV8QSIterMwAfnfhw2XJ8NRV
         8KzO+Zp6Tblyr2oSAZ7ZTqTrIslRfN2uu96MdS5tnTAKeq4r/TkutPStqlWfoxwVUlHc
         9yyMSebe3S3LMPkPAH7vmbvItRQKNlTmxNFSJJksfnfI3DsH3cFY7BEOMHXPAUR2wjC4
         b96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=u2FMbX0qnOvvgCDfzy715jd1Xj6Ekn6z7RRaJuXviOo=;
        b=588Rye/QlvFi/xalg693CiEjo+7umZeEONsqJ+wHQjAq3Iv919rnm39ehgF4gXsFxA
         uweC5ISQv2ESa2oP4pHhdd21biayaPOacUaQl7H+iU4LPfRWvpL5oKh8m5x8dn2R2qlE
         eGdCZVKqkGIHF+tPFSyEBERio2jGfGIecFvKHVmKACaaP1tm3zuZaxZmrR52T+LWQcpo
         d97k6yvuhmwaS9qupAeCaj6KLUyxsj50MvHC1RPFir7VwfR/bb6HJF9RIPqfvYqauHCQ
         KcL+sD1TGHwCpq9AUFAgPqRK4QkOSdC1SFAFKB7KCvxzRSTYJdUUHHToGzS4zgNOFgeP
         HhTw==
X-Gm-Message-State: AOAM530OjJAsmPnnrg/patvsrif43jmswWGgJn3tfgCYmbQPqqBdvFa6
        L2dIuhSVVikpBppDlB0QlmbTL4QXh/o=
X-Google-Smtp-Source: ABdhPJwfa4H9TB9+z/XPxe9I0qg6/jiT75XX7ewFsJXPD2GAvFqyYoFbdje7m665xc1PIJXEdQmkMg==
X-Received: by 2002:a17:90b:1c12:: with SMTP id oc18mr5224237pjb.174.1644535454482;
        Thu, 10 Feb 2022 15:24:14 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id z15sm16992176pfh.82.2022.02.10.15.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:24:14 -0800 (PST)
Date:   Fri, 11 Feb 2022 04:54:11 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>
Subject: BTF type tag not emitted to BTF in some cases
Message-ID: <20220210232411.pmhzj7v5uptqby7r@apollo.legion>
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

Hello,

I was trying to use BTF type tags, but I noticed that when I apply it to a
non-builtin type, it isn't emitted in the 'PTR' -> 'TYPE_TAG' -> <TYPE> chain.

Consider the following two cases:

 ; cat tag_good.c
#define __btf_id __attribute__((btf_type_tag("btf_id")))
#define __ref    __attribute__((btf_type_tag("ref")))

struct map_value {
        long __btf_id __ref *ptr;
};

void func(struct map_value *, long *);

int main(void)
{
        struct map_value v = {};

        func(&v, v.ptr);
}

; cat tag_bad.c
#define __btf_id __attribute__((btf_type_tag("btf_id")))
#define __ref    __attribute__((btf_type_tag("ref")))

struct foo {
        int i;
};

struct map_value {
        struct foo __btf_id __ref *ptr;
};

void func(struct map_value *, struct foo *);

int main(void)
{
        struct map_value v = {};

        func(&v, v.ptr);
}

--

In the first case, it is applied to a long, in the second, it is applied to
struct foo.

For the first case, we see:

[1] FUNC_PROTO '(anon)' ret_type_id=2 vlen=0
[2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[3] FUNC 'main' type_id=1 linkage=global
[4] FUNC_PROTO '(anon)' ret_type_id=0 vlen=2
        '(anon)' type_id=5
        '(anon)' type_id=11
[5] PTR '(anon)' type_id=6
[6] STRUCT 'map_value' size=8 vlen=1
        'ptr' type_id=9 bits_offset=0
[7] TYPE_TAG 'btf_id' type_id=10
[8] TYPE_TAG 'ref' type_id=7
[9] PTR '(anon)' type_id=8
[10] INT 'long' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
[11] PTR '(anon)' type_id=10
[12] FUNC 'func' type_id=4 linkage=extern

For the second, there is no TYPE_TAG:

 ; ../linux/tools/bpf/bpftool/bpftool btf dump file tag_bad.o
[1] FUNC_PROTO '(anon)' ret_type_id=2 vlen=0
[2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[3] FUNC 'main' type_id=1 linkage=global
[4] FUNC_PROTO '(anon)' ret_type_id=0 vlen=2
        '(anon)' type_id=5
        '(anon)' type_id=8
[5] PTR '(anon)' type_id=6
[6] STRUCT 'map_value' size=8 vlen=1
        'ptr' type_id=7 bits_offset=0
[7] PTR '(anon)' type_id=9
[8] PTR '(anon)' type_id=9
[9] STRUCT 'foo' size=4 vlen=1
        'i' type_id=2 bits_offset=0
[10] FUNC 'func' type_id=4 linkage=extern

--

Is there anything I am missing here? When I do llvm-dwarfdump for both, I see
that the tag annotation is present for both:

For the good case:

0x00000067:   DW_TAG_pointer_type
                DW_AT_type      (0x00000073 "long")

0x0000006c:     DW_TAG_unknown_6000
                  DW_AT_name    ("btf_type_tag")
                  DW_AT_const_value     ("btf_id")

0x0000006f:     DW_TAG_unknown_6000
                  DW_AT_name    ("btf_type_tag")
                  DW_AT_const_value     ("ref")

For the bad case:

0x00000067:   DW_TAG_pointer_type
                DW_AT_type      (0x00000073 "foo")

0x0000006c:     DW_TAG_unknown_6000
                  DW_AT_name    ("btf_type_tag")
                  DW_AT_const_value     ("btf_id")

0x0000006f:     DW_TAG_unknown_6000
                  DW_AT_name    ("btf_type_tag")
                  DW_AT_const_value     ("ref")

My clang version is a very recent compile:
clang version 15.0.0 (https://github.com/llvm/llvm-project.git 9e08e9298059651e4f42eb608c3de9d4ad8004b2)

Thanks
--
Kartikeya
