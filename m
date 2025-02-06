Return-Path: <bpf+bounces-50605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 456B1A29FD6
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 06:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E41B7A167F
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 05:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A492A1F37D1;
	Thu,  6 Feb 2025 05:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="C4wvILLt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554EC1F239B
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 05:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738818165; cv=none; b=pG0T82wPTZ8EI1vCluPfFKUiQayd4an4sr4ssXf98WSDxawq0uhhOtKq6QjREnhR8Mp0YVgHT9XNMwPfKUTjROktsAmEFohtmBZypjp51faqNMfmteCPXawc7UuUbiCW0RPLDbCwJo/A5NKxP+AmU17OV1JzXky1+Ty33rvHR6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738818165; c=relaxed/simple;
	bh=Har4jVIhJyKlCd6GcayEBIWVsi+oQrDxD0lkW5JLZ9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d49SXVVZXn3oFAKPoY6d1FSfi9YzxRRG9JWfq31F6/+Xw7QggguQW81VkJ7eLNs7ahB+BNHdrUH+OQw59VDzSQ8h220Ici1ekOz1o3WK6sy9QRYLO2pf+xFTi2XxI11H9HLXhZQGQvWXK0WS7oQ5FGSZx78eUfO3RZYButzmTC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=C4wvILLt; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dcedee4f84so810052a12.1
        for <bpf@vger.kernel.org>; Wed, 05 Feb 2025 21:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1738818161; x=1739422961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jW4EMIt8AGqhKN0XWrbnE99+Xzh8Dad6N9F+Cw1iIL4=;
        b=C4wvILLt+7rXANmWBal6ibuZu1hFSpeP7xGL0iFJCWdvnK8fe1gXU6QaJHT3s4Wx3d
         BAt/ZO/5meXlb9pR66nPYCDr6OOf6e8hHz29+DwnV5A1jH+2WN4e8ptoRDpsjjEDlnF9
         sczMraH9DWKSAFnRzwQD3tbGQIIz6eTN4bZ0H0j0mi1mt+uJtXFcME9apA+uNu3z52fD
         Eh6XGFFDDQsLHnh+L9d2pFtKr0+UQmItacC+ti9Svjelh/ZKv9doKDob9YwctblhQz9u
         O+XiEqEQbgHhcBTO8sn3/12ND/d8QDBnrgMGdf598dmKUGUDaBRIe+kni7Hlfpzubpr+
         gI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738818161; x=1739422961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jW4EMIt8AGqhKN0XWrbnE99+Xzh8Dad6N9F+Cw1iIL4=;
        b=mLwVR0uIpAsn0Yc4QQWzwlZ24SFMVvaTnDS/5iSyCLlSDGdnutUprN1n6XmZFSq+8E
         aL3lZqvZfPnvZacdCas0RYDzVy456HKtpemWYn7TY5WHhtE0bZq6ia4vcCwh3isV3L3U
         A168pB8peuPTvZlQvVdjNSZ8zIjhUOqIQE+P8R8nAxZ5huulEJPJYeAx5qTssv3I1FRr
         ZtV4ZTmvrV4A2l1WKbnofzieZ1APMGwr6hcbBkJ5Wuy6iBsSb7u7HHs54qo6IUgetnAA
         lzybDHFuiExE9HtJYZpzud0uT/1vPH65zqULKTX1q998b8nJ43iIIkDWmlJ9yxUtuMrJ
         Uc6g==
X-Forwarded-Encrypted: i=1; AJvYcCWlF7o5MsJA8nu6IPWHFBiVeeR2l8J864p12qke9nBxeVvPFTQjFW2K6xgedOxgKxxKPok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+90wkI60mooMnvjnReEKfBQzhhSoIfkof4qLUs1WMIEYzP3B5
	ZQm0fPdGN3st89Sg6ezg3/idEy8F97kwxosnbDS1IZDXqYSRwDpnRUCevMtDe3FlPTIQ0MPpUdQ
	3LGUl8I5fGYhxyQJ8icEoLzC5UpELKwyEVfdZKQ==
X-Gm-Gg: ASbGncvJBogWQw6lm22Y79TD8W6UVeXef8skaqChcXose7gqCgopXLf7bIFjKPNqhzZ
	LxY0CxJJNsSACrufQqj4nnjfcHO8P8rm8nwH2LhtckYKIdmlLK4PL7QubwC5NIxGdnimkRDpt6+
	kLVfJUX1XF5p5VU8M=
X-Google-Smtp-Source: AGHT+IEGYq93J8byd2URpzXaYtdGjS+rJCNrGGsDEPSdEdbwkThhL85aBrUZugD0Jt1ZNcSmdWEFuQcNfruj+nYensI=
X-Received: by 2002:a05:6402:3807:b0:5dc:eb2:570d with SMTP id
 4fb4d7f45d1cf-5dcecc4ee72mr1935759a12.2.1738818161509; Wed, 05 Feb 2025
 21:02:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z6JXtA1M5jAZx8xD@debian.debian> <d8893a20-4211-2fd6-e9d1-b65e81367950@huaweicloud.com>
 <CAADnVQLNSUOz7kSwMr0dfgT1gk02S1wNgJOhk-5h_d01AM2RbA@mail.gmail.com>
 <CAO3-Pbqbj_pi3BrA7h3qtRsrcm_wJVLnJwyKwuuNLYg==_QvRA@mail.gmail.com>
 <3d906727-1872-ca7e-759c-65c16b0f339f@huaweicloud.com> <CAO3-PbrNgZ-SDSCwNfKqeLK_ZSiq2zCXBQq7dM+PawRY9=xA_A@mail.gmail.com>
 <50dacbd0-48e9-c51c-634b-27f6c5fff439@huaweicloud.com>
In-Reply-To: <50dacbd0-48e9-c51c-634b-27f6c5fff439@huaweicloud.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Wed, 5 Feb 2025 23:02:30 -0600
X-Gm-Features: AWEUYZmvlMZyK26JF7d6-dNtR9wN_6K9WmXpYVB7eqv8oO0payB2T59Glv6rpF0
Message-ID: <CAO3-PbpUpOgymH0OdELvpG3XC1y3PXeM2yuJ6p3zXw0WKXnUUg@mail.gmail.com>
Subject: Re: handling EINTR from bpf_map_lookup_batch
To: Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 10:17=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 2/6/2025 11:01 AM, Yan Zhai wrote:
> > On Wed, Feb 5, 2025 at 6:46=E2=80=AFPM Hou Tao <houtao@huaweicloud.com>=
 wrote:
> >>
> >> Hi,
> >>
> >> On 2/6/2025 12:27 AM, Yan Zhai wrote:
> >>> On Wed, Feb 5, 2025 at 3:56=E2=80=AFAM Alexei Starovoitov
> >>> <alexei.starovoitov@gmail.com> wrote:
> >>>> Let's not invent new magic return values.
> >>>>
> >>>> But stepping back... why do we have this EINTR case at all?
> >>>> Can we always goto next_key for all map types?
> >>>> The command returns and a set of (key, value) pairs.
> >>>> It's always better to skip then get stuck in EINTR,
> >>>> since EINTR implies that the user space should retry and it
> >>>> might be successful next time.
> >>>> While here it's not the case.
> >>>> I don't see any selftests for EINTR, so I suspect it was added
> >>>> as escape path in case retry count exceeds 3 and author assumed
> >>>> that it should never happen in practice, so EINTR was expected
> >>>> to be 'never happens'. Clearly that's not the case.
> >>> It makes more sense to me if we just goto the next key for all types.
> >>> At least for current users of generic batch lookup, arrays and
> >>> lpm_trie, I didn't notice in any case retry would help.
> >> I think it will break lpm_trie. In lpm_trie, if tries to find the next
> >> key of a non-existent key, it will restart from the left-mode node.
> > I am not sure how lpm trie would break if we always skip to the next
> > key. Current retry logic does not change prev_key, so the lookup key
> > will always be the same. It would make sense if searching with the
> > same key could temporarily fail, but it does not seem so for both
> > lpm_tire and array based maps.
>
> Retry logic does change prev_key, please see "swap(prev_key, key);"
> below the next_key tag, otherwise the lookup_batch procedure will loop
> forever for array map.
>

We are probably not on the same page. Let me clarify:

By "retry logic" I mean this code snippet:
               if (err =3D=3D -ENOENT) {
                       if (retry) {
                               retry--;
                               continue;
                       }
                       err =3D -EINTR;
                       break;
               }
It wouldn't execute the swap when ENOENT is returned from bpf_map_copy_valu=
e.

And by "skipping to the next key", it's simply

  if (err =3D=3D -ENOENT)
       goto next_key;

Note the "next_key" label was not in the current codebase. It is only
in my posted patch. I don't think this would break lpm_trie unless I
missed something.

Yan

