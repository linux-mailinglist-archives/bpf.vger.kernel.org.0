Return-Path: <bpf+bounces-19244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26E7827C52
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 01:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45C2AB2291F
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 00:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FA8A31;
	Tue,  9 Jan 2024 00:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1qBy3Cl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51134635
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 00:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e7f58c5fbso2950790e87.1
        for <bpf@vger.kernel.org>; Mon, 08 Jan 2024 16:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704761876; x=1705366676; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tp7fzEF6CFPXSpdAks5XIznM3HRaZMbRvigJP3SL+gY=;
        b=a1qBy3ClzxXHy5LGn3BPfwT2vNgqTCxAJML5FKKgNqX1RY15IF/u8/zun7S9MLL6Jz
         9Os1+Flm5XPOq+lwygQL+tMdEI7f4TC+ZK51XAX6kUsp1CnHpkmXGwORN60ot1mvM9O4
         lLb0w4vnfoNBohrVLCFJm2KCr7SvsTX+otILr7jsWIV6n1SBAin9fs1PcdW2MB6d87Z+
         9+4sdH2c1sgTIz58akdUH09+L+oUKPz4h1bnXtak6gYWyl0KUgk9QwyAELs5t62eWpDN
         jsAPm+/oOiCQSTV3r8TXz5piQGla7sZybCOfMuua8Ppt9WBSyjRSKOzOuPAlyn00Xnln
         rsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704761876; x=1705366676;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tp7fzEF6CFPXSpdAks5XIznM3HRaZMbRvigJP3SL+gY=;
        b=Z1ro59+QDC1nf7tDBqnECsNRRT8d0XsjMbK4LuMV38LvzMe3RqtxpSkm61iwEYzUgt
         hU0wevZPgDxSx5XgghD8O8mXqun3U2o0/mStzAffscih1mAL95kdbe+BgJY5SiB0I62g
         eLlXsTurDPuN6V2vQ1bjsqpKwOBcAJkvk358WHGKInV0c0hI6heNsjTrpTrE08nlCwMh
         e61L/EQCIjDufPpVQc0v221ZffQ62LSbhFGIqbKvEJAMs8L3RueDwDe1rBztdwj7MbPh
         BzSHopjcw4Kb16o0ay8LKjTzYxh0JOCr0IaKGszf4TuaD4NUBCe+zJASkBLaOCo39Ah5
         0qxg==
X-Gm-Message-State: AOJu0YyZq4W6zZJKwUvYxbpBTWHgap5FhjnoT6KYVUXPSuhUYuo73b+5
	EYWDlbI9g17BrCD8/g91w810kFHW/pVpdw==
X-Google-Smtp-Source: AGHT+IEsqVJKKrEdL2s1FCKQqUv0bC2BfRorDcGzfenoOnRMT9LMVEFFCqsRC7NtPA2zixhHMY1S5Q==
X-Received: by 2002:a05:6512:402a:b0:50e:3479:3846 with SMTP id br42-20020a056512402a00b0050e34793846mr2569413lfb.68.1704761876003;
        Mon, 08 Jan 2024 16:57:56 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id er20-20020a05651248d400b0050e73a2ae87sm127351lfb.43.2024.01.08.16.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 16:57:55 -0800 (PST)
Message-ID: <9940a209ef0ab96b817d45a2b8282d1bb796240c.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: infer packet range for 'if pkt ==/!=
 pkt_end' comparisons
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  zenczykowski@gmail.com
Date: Tue, 09 Jan 2024 02:57:54 +0200
In-Reply-To: <CAEf4BzYSPGmMucCwADeKYcivyyvnf0jDvxuRGieMGeW8+Ci89w@mail.gmail.com>
References: <20240108132802.6103-1-eddyz87@gmail.com>
	 <20240108132802.6103-3-eddyz87@gmail.com>
	 <CAEf4BzYSPGmMucCwADeKYcivyyvnf0jDvxuRGieMGeW8+Ci89w@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-08 at 16:45 -0800, Andrii Nakryiko wrote:
[...]
> > @@ -14713,6 +14714,13 @@ static bool try_match_pkt_pointers(const struc=
t bpf_insn *insn,
> >                 find_good_pkt_pointers(other_branch, dst_reg, dst_reg->=
type, opcode =3D=3D BPF_JLT);
> >                 mark_pkt_end(this_branch, dst_regno, opcode =3D=3D BPF_=
JLE);
> >                 break;
> > +       case BPF_JEQ:
> > +       case BPF_JNE:
> > +               /* pkt_data =3D=3D/!=3D pkt_end, pkt_meta =3D=3D/!=3D p=
kt_data */
> > +               eq_branch =3D opcode =3D=3D BPF_JEQ ? other_branch : th=
is_branch;
> > +               find_good_pkt_pointers(eq_branch, dst_reg, dst_reg->typ=
e, true);
> > +               mark_pkt_end(eq_branch, dst_regno, false);
>=20
> hm... if pkt_data !=3D pkt_end in this_branch, can we really infer
> whether reg->range is BEYOND_PKT_END or AT_PKT_END? What if it's
> IN_FRONT_OF_PKT_END?

pkt_data !=3D pkt_end in this_branch means that there is an instruction:

  ...
  if pkt_data =3D=3D pkt_end goto <other_branch>
  ... <this_branch> ...

the 'eq_branch' would be set to 'other_branch' and AT_PKT_END would be set
for dst register in 'other_branch'. What's wrong with this?
Or did you mean something else?

