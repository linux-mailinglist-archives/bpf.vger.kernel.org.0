Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C0E460F05
	for <lists+bpf@lfdr.de>; Mon, 29 Nov 2021 07:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237453AbhK2G6P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 01:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbhK2G4N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Nov 2021 01:56:13 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF54C061397
        for <bpf@vger.kernel.org>; Sun, 28 Nov 2021 22:49:55 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id j18so19278237ljc.12
        for <bpf@vger.kernel.org>; Sun, 28 Nov 2021 22:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yWnzB5I8eCAYeC2Lf6NwTXLPs8N7oSGPlj5qq2JC6J4=;
        b=UABac1L9FEEP6YJckSzCrgI7cNhWRgjEJtiEpsRLsyi9+1Tcw8/aIWpydxTOoKmTNe
         hN7tj+jdtYpETbHUGW74/2S4A0jA9k8JTzolbf0/tlxxaMy48c+do4sgCJnha8wuT2TO
         XXdI/dZT4q5ZpyhY7A6ynoaxJFXK80dugYjtllR5MLDIIezwPgottOLui3qxZ0dwXpLX
         RKTMcdvfufZNofkEJHPdq8RdxlF0hjH/LlKzJ/H257dUinIDc3tM2UEfMq1eCS5vsx5O
         HRnLpndHlzGEe2tM0DxEYI4742Jvq6/1VWluTFLimc0lk0OaCC0F3gsF6mSYwUPNE6J6
         8XxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yWnzB5I8eCAYeC2Lf6NwTXLPs8N7oSGPlj5qq2JC6J4=;
        b=xi/FarILOtCyfT+bpSCtucdh92tyZp3SH2HtYttE4zrnMOkLJqRW2tAyNTYwpyo6GN
         rLvc78upFsM0Uu/BXbFVB+AxLmVCPs0xPAstKVeJDNrlmt0NkR8CJvMcLnUBXlYOKa4r
         dEdftWeYkLu1Ppi8OKjtkuagHB7VRCl1LQNCUvgbTaemSk5kYB9uoiASGqjbRJu8ldr4
         kV3TVe568bCRbcUhAs13gahab6ZzxBCa6BV5aqVshMBgEY+zYI2CFJ1i56KAi5ntGzcX
         NouqGEfyERlzo/7q2NH/NvPpAaYJLy5qtIf6TXv/fddGp4E6K0KFt2dFYCOo+RsNqS0z
         bbNQ==
X-Gm-Message-State: AOAM531LCJVJVF0xbjb26Exh9oRknATDSgMnpHsC+vn5vnKUIrlgMxlJ
        oE6qk7WKsiyOSAEtQZH1jIY1b4Avnm2veQtZbDE=
X-Google-Smtp-Source: ABdhPJxlN87obaHfHLzeKjMbHMg6Sfg/UJKHf+TNiqjo006KNAQASfgrObjQOks/n6B9jRQhh0vIi5WnxvY7Vi/VJzY=
X-Received: by 2002:a2e:a688:: with SMTP id q8mr47756189lje.349.1638168593540;
 Sun, 28 Nov 2021 22:49:53 -0800 (PST)
MIME-Version: 1.0
References: <CAPydje8FKWzRCR33RanGZkucavFZNb2zSGhfQdrd49Uvgc2YxQ@mail.gmail.com>
 <YaFCplDzX3NjN3iB@unknown>
In-Reply-To: <YaFCplDzX3NjN3iB@unknown>
From:   Yahui Chen <goodluckwillcomesoon@gmail.com>
Date:   Mon, 29 Nov 2021 14:49:42 +0800
Message-ID: <CAPydje8CG+X4tT=GU0SH=TD6fHJzfuBbSpFL86me_wEHT4At_A@mail.gmail.com>
Subject: Re: can add a new bpf helper function bpf_map_compare_and_update_elem?
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>, zhangwei123171@jd.com,
        zhaojianxing@jd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Cong Wang <xiyou.wangcong@gmail.com> =E4=BA=8E2021=E5=B9=B411=E6=9C=8827=E6=
=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=884:25=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Nov 25, 2021 at 04:34:48PM +0800, Yahui Chen wrote:
> > Suppose we have a map, MAP_A, and the user program does the following:
> >
> > 1. bpf_map_lookup_elem(MAP_A, key, value)
> > 2. change the value
> > 3. bpf_map_update_elem(MAP_A, key, value, FLAG)
> >
> > At the same time, the kernel's BPF program may also be modifying the va=
lue.
> >
> > Then we have concurrency problems.
> >
>
> This is why we have bpf spinlock. ;)
>

I get a bpf_spinlock example from
https://patchwork.ozlabs.org/project/netdev/patch/20190124041403.2100609-2-=
ast@kernel.org/:
```
Example:
struct hash_elem {
    int cnt;
    struct bpf_spin_lock lock;
};
struct hash_elem * val =3D bpf_map_lookup_elem(&hash_map, &key);
if (val) {
    bpf_spin_lock(&val->lock);
    val->cnt++;
    bpf_spin_unlock(&val->lock);
}
```

But, I think bpf_spinlock cannot be used in user mode.

>
> > Therefore, can we add a helper function like compare and swap?
> >
>
> I don't think you can atomically compare and swap values larger than
> CPU word size.
>

Yep, you are right.
So I imagined adding something code like `memcmp` to the kernel before
update bpf map element.
If memcmp success then update the element, otherwise return fail.

New helper function looks like:
bpf_map_compare_and_update_elem(MAP_A, key, old_value,
new_value, FLAG)

>
> Thanks.
