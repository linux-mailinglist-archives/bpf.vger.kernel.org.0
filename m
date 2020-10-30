Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D1A2A0D43
	for <lists+bpf@lfdr.de>; Fri, 30 Oct 2020 19:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgJ3SUb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Oct 2020 14:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgJ3SUb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Oct 2020 14:20:31 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1837C0613D5
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2020 11:20:29 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id f6so5919393ybr.0
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2020 11:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=51Ky1A37m0KLXARbMA/xuRzb6qNQEPjjCd1wcTWqlOQ=;
        b=FKNNHCsgBBbqLLcAbOAbPNfgUB8are8I6QJUcwWrYcxizw/BYdIIg7mWaOydxxRnVZ
         BTnzc3AvmqZbsO67l1TYasGn8G0dGxJzk4MoxKu6RmMWzJozXpfn4ezlaWtq/iZ7JboS
         FhWwAL+3MLUlqxDZl7nCLxuyGwAssnNoQiHMnoqvvcni5ULKD8ux4ub72wLQmW7yKkFb
         PoAgPx3BrCH+Lnrj/IDSzb2eW3VrTWuujDramrIDoSoKPTo4410sFx20mtbsMFCaqvz5
         bNxOZ+CTVXQNKKr1PI//A0P+QpjwIKCDwq9yadC/L6a64l/TdBEh9WvRgVDQcQI54DLM
         BAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=51Ky1A37m0KLXARbMA/xuRzb6qNQEPjjCd1wcTWqlOQ=;
        b=PYXUuTSqfGq15BjNvUXgV0+6b3lgEmVK7G2cHaCLpuXuqrtBq+vD5UvY9VwY6xu1fD
         U1NuSE76yZwfRgppfXpzs0Q+vMN14U74Lv03+TWPJMEC7owK6p0nQsI5M1AXJdVMXUda
         Sb4aDHP4gRO4k6vmLX6wZH9bew+G2LdihLJcsW9d0EWGPbiUGDrwYNSL5yCCbnQrOqaH
         sYOn3rGledWW30XiSVOxSvvl6Hzxl9LZGlxe0rVCPbvPZvHpoCySfTQhURY/OZsRQxha
         5rrE72FS7mAJo71Ki4ChjZMz4L9wlRimW4HI28Qr+vRo+zwQ4oE7g9OPyI5eeE8DgrhC
         7rhg==
X-Gm-Message-State: AOAM531KB9JeJZaeSf7uJ/Zgx+1eGt8Hs4a4/W9mvQvTwEPd8u46oxou
        DiX8VECmAF3bD2D38wW6QKFugutqEMTP/XPyi0I=
X-Google-Smtp-Source: ABdhPJwafnk9PSVz2BuSzQnL3uGReX9/nE9JBXsrktqguUEbZYXQyriRWz0eNyc9HEv+qClGSuzy5YBvjOpdTxMY7jY=
X-Received: by 2002:a25:b0d:: with SMTP id 13mr5461483ybl.347.1604082029056;
 Fri, 30 Oct 2020 11:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR8303MB008003C9E3B937033A593C47FB150@VI1PR8303MB0080.EURPRD83.prod.outlook.com>
In-Reply-To: <VI1PR8303MB008003C9E3B937033A593C47FB150@VI1PR8303MB0080.EURPRD83.prod.outlook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 30 Oct 2020 11:20:17 -0700
Message-ID: <CAEf4Bza-KX7C5ghXSVs30R_xkKtqjDwM8snH2B2A_VCAxSim2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: update verifier to stop perf ring buffer corruption
To:     Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        KP Singh <kpsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 30, 2020 at 5:08 AM Kevin Sheldrake
<Kevin.Sheldrake@microsoft.com> wrote:
>
> As discussed, bpf_perf_event_output() takes a u64 for the sample size par=
ameter but the perf ring buffer uses a u16 internally.  This results in ove=
rlapping samples where the total sample size (including header/padding) exc=
eeds 64K, and prevents samples from being submitted when the total sample s=
ize =3D=3D  64K.
>
> This patch adds a check to the verifier to force the total sample size to=
 be less than 64K.  I'm not convinced it is in the right place stylisticall=
y, but it does work.
> This is the first patch I've submitted to this list so please forgive me =
if I'm doing this wrong, and let me know what I should have done.

See [0] for some guidelines. I use git format-patch and git send-email
for my patch workflow. And please make sure your email client/editor
wraps the lines, it's hard to reply if the entire paragraph is one
long line.

  [0] https://kernelnewbies.org/FirstKernelPatch

>Also I don't know what the size reduction of -24 relates to (it doesn't ma=
tch any header struct I've found) but it was found through experimentation.

So -24 should have been a clue that something fishy is going on. Look
at perf_prepare_sample() in kernel/events/core.c. header->size (which
is u16) contains the entire size of the data in the perf event. This
includes raw data that you send with bpf_perf_event_output(), but it
can also have tons of other stuff (e.g., call stacks, LBR data, etc).
What gets added to the perf sample depends on how the perf event was
configured in the first place. And it happens automatically on each
perf event output.

So, all that means that there could be no reliable static check in the
verifier which would prevent the corruption. It has to be checked by
perf_prepare_sample() in runtime based on the actual size of the
sample. We can do an extra check in verifier, but I wouldn't bother
because it's never going to be 100% correct.

>
> Thanks
>
> Kevin Sheldrake
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index e83ef6f..0941731 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -18,6 +18,13 @@
>   */
>  #define BPF_MAX_VAR_SIZ        (1 << 29)
>
> +/* Maximum variable size permitted for size param to bpf_perf_event_outp=
ut().
> + * This ensures the samples sent into the perf ring buffer do not overfl=
ow the
> + * size parameter in the perf event header.
> + */
> +#define BPF_PERF_RAW_SIZ_BITS sizeof(((struct perf_event_header *)0)->si=
ze)
> +#define BPF_MAX_PERF_SAMP_SIZ ((1 << (BPF_PERF_RAW_SIZ_BITS * 8)) - 24)
> +

[...]
