Return-Path: <bpf+bounces-73749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5031BC38622
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 00:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F1E01A21A54
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 23:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BE92E54B2;
	Wed,  5 Nov 2025 23:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ts7QTdIw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E77190664
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 23:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762385883; cv=none; b=hZ5gY5WpX32XtFeX8LrN3s2Py/Vmkfyj9KWdHw65m7ELKoBAH8WdLZsEmicU2c3U6C3BA4qwyfX3tUtU7TIi5KoFjVKuZ0otKpdjd8Pe7jZlYVVBkIT16JVeabYN79PDAToe495o/MbIgpdxIfMKVYfnsM7bnEqapsE/oNHDGQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762385883; c=relaxed/simple;
	bh=gddbQ+Itd7Ojfjtk5FdtrnY3uKmgUByG80qPQ8ZvjtI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Be32l/MHahZr90sePsnLBwrCMDWa1swg8pYlLhPbuy30Dbnu8lPwl0S3XvL/1WcnshCqJ7url4FQcaYfLgti/hgoWZXdPNnezDVrovw1HMSfD6G/nB2cLYqzYrSLXo6+0BZ+ZK2Z6eW5Uj+j6D4O++TZC/jRa3u9XjHrkLWWtOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ts7QTdIw; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7ae4656d6e4so510148b3a.1
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 15:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762385882; x=1762990682; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9fVUkHQDwvPqUlHZQUDqXxahAxilIHdqJl6WVxMgWaU=;
        b=Ts7QTdIwxedzHjNtuBEutS8NMj3e0wM2n0iSMtVTksR7dN8sm42V1tkG3/v2KLJyYw
         Tv7oxmQ2DcPmWlre6lHfEA1bmsqf32R1mNM8jJ1DCblQnadH69dU5CJXXqrC+BJJq2Gc
         MZO3EAnDBap2597JRSgnA5rPEP/dRuAr0wrtt+JZWQ56d6fGHly5vDBVl7ORGyG0vLVP
         Quer3xi+3JB8s/qdnVnhJuoqC/HMuQ0qtmJif7ZuceC1mVJUTzaq3WHopKgAi63KQczw
         esegAGBRH22BWfY8t53ll8SAj/QXqhMrAapzaVH7WZQqi5Mlihb+n4tMVQaauiEeLz0J
         jrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762385882; x=1762990682;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9fVUkHQDwvPqUlHZQUDqXxahAxilIHdqJl6WVxMgWaU=;
        b=Oyg+oQkV3ceN5ndZXJ4GISpTJvcHNLMtKITGcaWvkCrR/twX4l511genEobNv2pUQW
         ViG8tzcT9PrHZlJwnmzdWzXQXmmmWCv2BGcTkUgrfetjTXXUepd62Mt61VAn+E1Pymms
         w7aJ44UFt8GQHROSCyH6PfQhN1IslUwzZwxP1jhuu716RE2OhBLqkUc+3eX1UMQ4VFnA
         J68rRQ6ZJztyoreLVcWmNCPAaFYpicUtPECtx3VGUOZ5uR3+c9FQTBIuhqy58WyWBvyw
         6cggSD7PkKeKtlfB2Sdhf81CMnyHALhfPGnL0SalqCBmjVWM95FewJu3vt04RPmXg9Sk
         s6yw==
X-Forwarded-Encrypted: i=1; AJvYcCXSjntnqgu12FRVLeGAFVNaNazRAqLunjywPwHBQ6Xg16dBmmGRolw1AkPVO2c1LG9eJHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMK7bAYibb95KlIxmANUOeQeWsHEZerVwuZljKb2oy10foe4Ia
	fEP8W61mGJnSyCYYi8jH34A7XGBFrC+e3tw/IAHkXCgVUhg2ajsvUryV
X-Gm-Gg: ASbGnct9mS/2UHEVrdXj6CmkYz54zGIcvFV9TqCLmqcIliYwRGIJ6FnqYlMcbYHp7xr
	Z1QWUmAnBInr7G2JQfqIQr/KbOIiMZLXM0qIteMb1SyfPcwvkENyP+qtlTuGOKgz5rKmYYmbhaZ
	6no758uS11c3jJttU5m3pyjbAl2UN/PRO/uvfDHXi4xK0u+q9Q9CuySi+Id+d574VOVlgoaV/7c
	+0a5c7Blzj4eY2pJzOBS9GbEoWeHCv3a5nlwS11JcGXOwB2dNi174Ws3mILmLYXEpka0rvTS9Ow
	NqRrmiDnShtAjpOhfRcFoe3F6PrJUi/aqZoYQ786zuasT88UJGtQnWnzfv5ZFm9j/cK1RYQJMlF
	ZvZtSAY4rwQx5UuOxJq22KMrevRsvsLhnaji7o7ZmakDa9hsMu9mk4swJ67czKYi/57BSH/nrAb
	braKxv9k1Xi9LSSB1upMBd3y+o
X-Google-Smtp-Source: AGHT+IF5T6+DOCSnDpoLDg2pzh3olheTdfkjvm41AL9sLBEpMp4B3RXVO38qeeSA3u2FwUTtP18r/A==
X-Received: by 2002:a05:6a20:12c3:b0:331:e662:c97e with SMTP id adf61e73a8af0-34f85511aabmr6954608637.37.1762385881643;
        Wed, 05 Nov 2025 15:38:01 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:cdf2:29c1:f331:3e1? ([2620:10d:c090:500::6:8aee])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68ad143sm4020376a91.3.2025.11.05.15.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 15:38:01 -0800 (PST)
Message-ID: <8541c5bb758bc06e8c865aaa4f95456ac3238321.camel@gmail.com>
Subject: Re: [bpf-next] selftests/bpf: refactor snprintf_btf test to use
 bpf_strncmp
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Hoyeon Lee <hoyeon.lee@suse.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,  John
 Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, "open list:KERNEL
 SELFTEST FRAMEWORK"	 <linux-kselftest@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Date: Wed, 05 Nov 2025 15:37:59 -0800
In-Reply-To: <CAADnVQJVYDbOCuJnf9jZWdFya7-PfFfPv2=d2M=75aA+VGGayg@mail.gmail.com>
References: <20251105201415.227144-1-hoyeon.lee@suse.com>
	 <CAADnVQK7Qa5v=fkQtnx_A2OiXDDrWZAYY6qGi8ruVn_dOXmrUw@mail.gmail.com>
	 <b3f13550169288578796548f12619e5e972c0636.camel@gmail.com>
	 <CAADnVQJVYDbOCuJnf9jZWdFya7-PfFfPv2=d2M=75aA+VGGayg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-05 at 15:33 -0800, Alexei Starovoitov wrote:
> On Wed, Nov 5, 2025 at 2:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Wed, 2025-11-05 at 14:45 -0800, Alexei Starovoitov wrote:
> > > On Wed, Nov 5, 2025 at 12:14=E2=80=AFPM Hoyeon Lee <hoyeon.lee@suse.c=
om> wrote:
> > > >=20
> > > > The netif_receive_skb BPF program used in snprintf_btf test still u=
ses
> > > > a custom __strncmp. This is unnecessary as the bpf_strncmp helper i=
s
> > > > available and provides the same functionality.
> > > >=20
> > > > This commit refactors the test to use the bpf_strncmp helper, remov=
ing
> > > > the redundant custom implementation.
> > > >=20
> > > > Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> > > > ---
> > > >  .../selftests/bpf/progs/netif_receive_skb.c       | 15 +----------=
----
> > > >  1 file changed, 1 insertion(+), 14 deletions(-)
> > > >=20
> > > > diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c =
b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > > > index 9e067dcbf607..186b8c82b9e6 100644
> > > > --- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > > > +++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > > > @@ -31,19 +31,6 @@ struct {
> > > >         __type(value, char[STRSIZE]);
> > > >  } strdata SEC(".maps");
> > > >=20
> > > > -static int __strncmp(const void *m1, const void *m2, size_t len)
> > > > -{
> > > > -       const unsigned char *s1 =3D m1;
> > > > -       const unsigned char *s2 =3D m2;
> > > > -       int i, delta =3D 0;
> > > > -
> > > > -       for (i =3D 0; i < len; i++) {
> > > > -               delta =3D s1[i] - s2[i];
> > > > -               if (delta || s1[i] =3D=3D 0 || s2[i] =3D=3D 0)
> > > > -                       break;
> > > > -       }
> > > > -       return delta;
> > > > -}
> > > >=20
> > > >  #if __has_builtin(__builtin_btf_type_id)
> > > >  #define        TEST_BTF(_str, _type, _flags, _expected, ...)      =
             \
> > > > @@ -69,7 +56,7 @@ static int __strncmp(const void *m1, const void *=
m2, size_t len)
> > > >                                        &_ptr, sizeof(_ptr), _hflags=
);   \
> > > >                 if (ret)                                           =
     \
> > > >                         break;                                     =
     \
> > > > -               _cmp =3D __strncmp(_str, _expectedval, EXPECTED_STR=
SIZE); \
> > > > +               _cmp =3D bpf_strncmp(_str, EXPECTED_STRSIZE, _expec=
tedval); \
> > >=20
> > > Though it's equivalent, the point of the test is to be heavy
> > > for the verifier with open coded __strncmp().
> > >=20
> > > pw-bot: cr
> >=20
> > I double checked that before acking, the test was added as a part of [1=
].
> > So it seems to be focused on bpf_snprintf_btf(), not on scalability.
> > And it's not that heavy in terms of instructions budget:
> >=20
> > File                     Program                  Verdict  Insns  State=
s
> > -----------------------  -----------------------  -------  -----  -----=
-
> > netif_receive_skb.bpf.o  trace_netif_receive_skb  success  18152     62=
9
>=20
> Is this before or after?
> What is the % decrease in insn_processed?
> I'd like to better understand the impact of the change.

That's before, after the change it is as follows:

File                     Program                  Verdict  Insns  States
-----------------------  -----------------------  -------  -----  ------
netif_receive_skb.bpf.o  trace_netif_receive_skb  success   4353     235
-----------------------  -----------------------  -------  -----  ------

So, the overall impact is 18K -> 4K instructions processed.

