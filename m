Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031D55FAB11
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 05:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJKDTF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 23:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiJKDTB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 23:19:01 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B73A84E7D
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 20:19:00 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id l19so8229190qvu.4
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 20:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=txtED7KuGeIHz2icfhvYqabaJOWsZ+jSIAoGr7nFXU4=;
        b=etKE6aJ6hu+7w9VJZDCzwJnjw915Q2zMbODuBIkUftEEdGqh8+uVYHpWnR0TappESo
         XhkJvfFPf3mTPCHj2baFDVJ7q033UjjZ6Oxu5TXZWFjxHSXRlAoPQQkQrSCpQuVnU76a
         sJn9e9QldCiHaz/mU9dt6R6zlkKrEXEJwj7uh9S5tR3lpK+zO2nixqArCt7448RDYueB
         OCYT9JUsHrLUn6zB+ScmYD6Vf1OPCp+oDFbM6KQUcP4s5ONOtgBazWdB3T/wFkWWlSVN
         GUrnHSWils24oo9eD8A9SNtXpc9wmXY5j7lKaE0xbPZ3WYzEa37c9eTxaf3w/ImbOTyt
         9yeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=txtED7KuGeIHz2icfhvYqabaJOWsZ+jSIAoGr7nFXU4=;
        b=nKcBAwOIAwL19fGLsVbFpuxB0SvykXJmlxok5KzWS7G7ENLhFOX8gALD6Vl+an6AOH
         m1FX1VaPrSRWxR/7iKkv9E21tRgrq5X2Zqut1Pm07YgfdR3x8lDP+I38FgJhoQVg6EBl
         kgUdbTrcwHraYA2NMvxu172I6ACsWkenhT9QxzYzvJWdJ5DL/WxVGYZS1XcsP8NMpWTY
         pNXzY7Naa0E9jeC4lwbvP919hBBa+VVVFWjKlh0Kbb9L3lezgXdqYvQo2lOsyPtowdyv
         tB1O2v+DwsMHiYO6IPr+S8Un5ukMELPYDHpiEgxzWSptRKuGuPqGqxSaQ3IZ+JQWE7qk
         JkpQ==
X-Gm-Message-State: ACrzQf2zUImPjD4wnnJkn7duRCYfUU2A/qSSSBOpfuzflJD60moGGckH
        V/Wx1UdY3iRdmopFrGLD2os+F4gURy5BM8uP4qvRam1kiw2i/Q==
X-Google-Smtp-Source: AMsMyM7yf6r9g+eGzV2eCpyGS75stKn7ybIoiskXGEUZXR5hFzCRjeHcARV7Xue6sRDPI2YNnQyOLxXdzA2XXG6JlVQ=
X-Received: by 2002:ad4:5dc8:0:b0:4b3:2bd2:5158 with SMTP id
 m8-20020ad45dc8000000b004b32bd25158mr15274624qvh.30.1665458339184; Mon, 10
 Oct 2022 20:18:59 -0700 (PDT)
MIME-Version: 1.0
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 11 Oct 2022 08:48:22 +0530
Message-ID: <CAP01T75b+YsU7suqaM8wk_ty3F2SkVew+6HrFGF8GaUsw=_xdA@mail.gmail.com>
Subject: Symbols with double underscore prefix are not emitted to BTF .ksyms DATASEC
To:     bpf@vger.kernel.org
Cc:     yhs@fb.com, ast@kernel.org, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I discovered that for the following program:

 ; cat bpf.c
extern void *__bpf_kptr_new(int, int, void *)
__attribute__((section(".ksyms")));
#define bpf_kptr_new(x) __bpf_kptr_new(x, 0, 0)

struct foo {
        int data;
};

int main(void)
{
        struct foo *f;

        f = bpf_kptr_new(0);
        return f->data;
}
--
Compiling and dumping BTF shows that the __bpf_kptr_new extern is not
added to .ksyms DATASEC.

[1] FUNC_PROTO '(anon)' ret_type_id=2 vlen=0
[2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[3] FUNC 'main' type_id=1 linkage=global

However, removing the leading double underscores fixes this:
 ; cat bpf.c
extern void *bpf_kptr_new_(int, int, void *) __attribute__((section(".ksyms")));
#define bpf_kptr_new(x) bpf_kptr_new_(x, 0, 0)

struct foo {
        int data;
};

int main(void)
{
        struct foo *f;

        f = bpf_kptr_new(0);
        return f->data;
}
--

and dumping now shows:

[1] FUNC_PROTO '(anon)' ret_type_id=2 vlen=0
[2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[3] FUNC 'main' type_id=1 linkage=global
[4] FUNC_PROTO '(anon)' ret_type_id=5 vlen=3
        '(anon)' type_id=2
        '(anon)' type_id=2
        '(anon)' type_id=5
[5] PTR '(anon)' type_id=0
[6] FUNC 'bpf_kptr_new_' type_id=4 linkage=extern
[7] DATASEC '.ksyms' size=0 vlen=1
        type_id=6 offset=0 size=0 (FUNC 'bpf_kptr_new_')

This is on the latest clang nightly.

Thanks.
