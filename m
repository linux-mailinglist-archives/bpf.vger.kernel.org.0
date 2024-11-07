Return-Path: <bpf+bounces-44185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2769BFABE
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 01:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72F19B226BD
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 00:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAAE4431;
	Thu,  7 Nov 2024 00:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TagWdYSJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277A9802;
	Thu,  7 Nov 2024 00:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730939186; cv=none; b=c4c3WxjILb86DI+Ua3MNnjAyDNJxTh2FzdSGIac8asAC/nIjtS1FYXXRIRKH1WeiWXIbGhESmIAT1UMqBIwXv7rQBGNR5DXUt0yFpPIZSO1bw64G6h8ClowqIpHGxiwA9MALMqL6atpyx3Gg/TIcA7SpDCqCNUlnge14O3fKO9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730939186; c=relaxed/simple;
	bh=BYcO46ac94EKS6Mh/S5vc+Sx8jDbyJPYpl6uBCkdrJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zry+gqD6UbzwB/6ub1orFWkdefOLlm85x65TW4Erxmqc2X2+eFfGvgsTpX/Zp1m+YHz9bO0tw2XOvF2eaPDVMo44RtrVaVdjoPbxuFYPYGNPw5R2YkUFFUgwo4OtjKmMnKoDIlIRMShUopmjleDDnoKyIksZiB5X9hQjL3kt/u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TagWdYSJ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-72097a5ca74so288597b3a.3;
        Wed, 06 Nov 2024 16:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730939184; x=1731543984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4aH1hb7FOSZ2lcA1sVIvRlhmUL4cmhdy5t9v7p62eZQ=;
        b=TagWdYSJQIiZ0iIRITOUvjHZb1/iQ8GobjvpXLZ/VBrBCTXctcqeokXQ7OtiIDojP3
         DrExONwX0N39ZAXDk+rGitCO4EZ3BPvRvMzBOJGt88HKTOlxqH7BIZCGHYCHvJbqrEFj
         5YHCEMK+j8iVJRWvTAv4KE8QvrbsKugE70LlEsqZB0lrU21BqJpCDyY0nxUjsb46UC9A
         ezN8sZDn1jsT4xo2F9gpsw4Mxdc/M11MTCzbd3EMDuoskB8LgEteg2lvi5Oqcfidce2b
         es8UdaPCWlU+pg1jOVD/CiyXxSMyvX3Ywoi9bZ3x5UWVhbh8GP7vk7IkvP5xXFHNbkhx
         Rl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730939184; x=1731543984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4aH1hb7FOSZ2lcA1sVIvRlhmUL4cmhdy5t9v7p62eZQ=;
        b=KqV4jIgvJcPpPSmVvUCCo1AZ9p/zehtuRB6anlQDSPwFqutNs5gzzAXNUHAtRrOOfx
         8olUep5xK3V+cIqD2EFK2/G5ui+zp8QU6kqUFtSVyzrZPAPuF+MymIoZAlo81u7+i0kE
         rpfSAc+cW7zA6EUaCxsDuoNQKpPGGrq4vO0vJQ3JfDX/afd8Q4AhgVIwtA0GuM8b8g0c
         v1iWdHsUByGkoXWr1fViQ6zjEUupFZzH9e73QhJ68wH6cJEX2IqJ7fjz2PfFjaHrA7cR
         cncTi3GzeOvklLbArxcQoXx13MUVZIieXM7MMqwHiD04g0TvEZCB3Fyq2Weg5jm3uCwH
         9y2g==
X-Forwarded-Encrypted: i=1; AJvYcCV74mbGnAId53I55wJzhrR+u6bsXAMeUUHErzwcq5Y6gbHIsT57WCIDCNTxi10kKh3zhONNqFJxxUNGrO7RbN87iw==@vger.kernel.org, AJvYcCX3QtmMbWXzYNNVW/fctxAKVjxYT8++NmqU3eQx43QTaI1T+Yjv6f7DRZQ0henE9Ql5lZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPH6GxpKIqQAwk8/OwpC7dZDmnJCo2MDbTtAwyX8KYQuwf662Y
	qYs4FaALFF0eRdrD1p4GnrMvaLqQq8i5ToKkU4ObVLnzOnMhHmgfLvI1zia4aKCeijcUOHBgrQF
	c2oHohc6vJxaYbA2tggbfThjS1fE=
X-Google-Smtp-Source: AGHT+IGKqFT+RkOHzMA+H/5SB6c1zGnlNJhM8TDzrZPomgishMO3mPwfd5uu1B/kX+S34b50nJKjkmdkSS8HhKExBD8=
X-Received: by 2002:a05:6a20:244b:b0:1db:f099:13b9 with SMTP id
 adf61e73a8af0-1dbf0991414mr12324674637.43.1730939184329; Wed, 06 Nov 2024
 16:26:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106224025.3708580-1-jolsa@kernel.org>
In-Reply-To: <20241106224025.3708580-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Nov 2024 16:26:11 -0800
Message-ID: <CAEf4BzZ9wd4ZRGk=Gp3dXOVC5W2=ap90FcQaa9XmAmhY-4CCvw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix uprobe consumer test (again)
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Sean Young <sean@mess.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 2:40=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> The new uprobe changes bring bit some new behaviour that we need

needs some proofreading, not sure what you were trying to say

> to reflect in the consumer test.
>
> There's special case when we have one of the existing uretprobes removed

see below, I don't like how special that case seems. It's actually not
that special, we just have a rule under which uretprobe instance
survives before->after transition, and we can express that pretty
clearly and explicitly.

pw-bot: cr

> and at the same time we're adding the other uretprobe. In this case we ge=
t
> hit on the new uretprobe consumer only if there was already another uprob=
e
> existing so the uprobe object stayed valid for uprobe return instance.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/uprobe_multi_test.c    | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index 619b31cd24a1..545b91385749 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> @@ -873,10 +873,21 @@ static int consumer_test(struct uprobe_multi_consum=
ers *skel,
>                          * which means one of the 'return' uprobes was al=
ive when probe was hit:
>                          *
>                          *   idxs: 2/3 uprobe return in 'installed' mask
> +                        *
> +                        * There's special case when we have one of the e=
xisting uretprobes removed
> +                        * and at the same time we're adding the other ur=
etprobe. In this case we get
> +                        * hit on the new uretprobe consumer only if ther=
e was already another uprobe
> +                        * existing so the uprobe object stayed valid for=
 uprobe return instance.
>                          */
>                         unsigned long had_uretprobes  =3D before & 0b1100=
; /* is uretprobe installed */
> +                       unsigned long b =3D before >> 2, a =3D after >> 2=
;
> +                       bool hit =3D true;
> +
> +                       /* Match for following a/b cases: 01/10 10/01 */
> +                       if ((a ^ b) =3D=3D 0b11)
> +                               hit =3D before & 0b11;
>
> -                       if (had_uretprobes && test_bit(idx, after))
> +                       if (hit && had_uretprobes && test_bit(idx, after)=
)

I found these changes very hard to reason about (not because of bit
manipulations, but due to very specific 01/10 requirement, which seems
too specific). So I came up with this:

    bool uret_stays =3D before & after & 0b1100;
    bool uret_survives =3D (before & 0b1100) && (after & 0b1100) &&
(before & 0b0011);

    if ((uret_stays || uret_survives) && test_bit(idx, after))
        val++;

The idea being that uretprobe under test either stayed from before to
after (uret_stays + test_bit) or uretprobe instance survived and we
have uretprobe active in after (uret_survives + test_bit).

uret_survives just states that uretprobe survives if there are *any*
uretprobes both before and after (overlapping or not, doesn't matter)
and uprobe was attached before.

Does it make sense? Can you incorporate that into v2, if you agree?


>                                 val++;
>                         fmt =3D "idx 2/3: uretprobe";
>                 }
> --
> 2.47.0
>

