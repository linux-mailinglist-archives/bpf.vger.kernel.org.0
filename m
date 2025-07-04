Return-Path: <bpf+bounces-62447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB4DAF9BE1
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 23:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B364D3B083C
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 21:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7671228CA3;
	Fri,  4 Jul 2025 21:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B74npjwp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AF02E36F6;
	Fri,  4 Jul 2025 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751663600; cv=none; b=BL+b8DMj4A2+clVDSXpDaakutrtySU5d69wkDDBjYydY/SOiU6MtemgF09u/MpOP8G2Z0bUXkL3HX0dubU+rTzOCe+lvTvt15xI6hyykMdEf6v36/IUSye02ZS9nSNE45XPLq918xwdLxU5bUIFWsRMvY+NZUeO22K0s2qaYTf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751663600; c=relaxed/simple;
	bh=zT57kjzSuc2YjOZ/13Q1WCxljHbZ3simyydCTfUXuoc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S+vh8oj/AK0cIyVabkCcxdbBkU3HQrAinwCOg+Zqe3iUoegbGHcbwyxd9O/T+iexpRd9SBeHAbnwvp2B9pV5RVlcOs3zpKfnlaP/4Pzv3d9lQiAEHxJNCnBLrZeD0RxQIba1QBN2fB1SDJxLjwmsJhW+P/BjLdXVtz/A/rg9cg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B74npjwp; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23602481460so13414675ad.0;
        Fri, 04 Jul 2025 14:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751663598; x=1752268398; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Eged04V15WcYZIT4EIvtaTKSNXjWorwpdzN3lCt28So=;
        b=B74npjwpMTeRc93hhau2GFuy0QnJ/qnVTXmb76GSAJFEI73faxjiWZhS52RY7YFrm+
         CW3oDdpSDrKCP65wHiPNENizb1Ajin78F5c5ZeFzQZpWCz5VirL6vBNw5seUf4tp4nJF
         MhSlYKi4eYB+FgCqhsBLQcyY1j68ME0Ap2LBZf1LvPChDM1c/2vXuvFLHx5ZzW+Ai2i8
         DrFxFM96R/L+ys8JRUlo9U340/M3REFrX+F+j4Y4GBjKmFR95HZYkGHCF+ytheKBpHGF
         Yyy2eu/1CMKsniSzmUYrAYSjivorh90ZkO7zFISEaLyIhW7B2wFaVQdzWhriXziDkL2b
         XUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751663598; x=1752268398;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eged04V15WcYZIT4EIvtaTKSNXjWorwpdzN3lCt28So=;
        b=F3IYILu77xgpxTPvInZGn13+HYGhUKyd8mYlLjGH+baE1assqzsfqabB5BIcaS4H7B
         Z79TbxYkfBfL1GWbLepMUN5GsXxoeqKUW4aoUDvYcWqJ98ndaqjyFj2Hxlk8Lg2fNzkB
         z/6JXB9cnFBk+XubAf1eW9LK+qxbDtoL7CCDE5Pn6aKnldeBCkOS7BZidxSIgDcCzvCS
         NNi5FHA67ZM9PAwx9IVZm3WgLzBCwpa9NG83NayCOzgoSALFUI2zcrnr8erIqauGO7dd
         Zocp1zuIyf3Wicd0jK70VfYBmJnQoGlVuMhPu0DMTv9AUVvP+XH1TZsJjVhs3o26s0c9
         Wunw==
X-Forwarded-Encrypted: i=1; AJvYcCVn8BymwuOVT1eSjaroG+ghY6Nt4KypbY0NMSfVA5nsCuHMZWEDmjQ3lS3meChholTcRsxLuNyIfIPTQe+R@vger.kernel.org, AJvYcCWSRQyWWtfV2mEtW3awOQjBVgzg6j4aXrR7Jhjh0NVLmkogVt54OyMeeukzCJvPMz3qv6AJewp4@vger.kernel.org, AJvYcCXnDLDbc7zs8wuG30HA1RkHGjPQkcQxnIy/WdvAlXgV6ib4CJmJ2DwJn8bMNwaqCp6g8/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5aUAfRxjmEVs3Z1/r28TsSJRne3zHWX4dSg6/nDQLxe54Zvjb
	ZfsX9bICZz6wQCVAMR//RkhQ2pOi3jGPCEKxcnoYK4vptRsCkSdfBXuH
X-Gm-Gg: ASbGncs4T30CjzP5DJWCLt0bYSekiylHZW3+6mK7zFLgH13IzM4jAFI21zCUJhCj7/d
	7cfVdNVpOAdl2Hi99P6eV87BFW3eudno2CU6gbMsqDUx2voHJ4grv32/c1K8k3RmApjWFkPL2Pp
	JYvpBiF6hfvNYVwqJNhBQRAH5YaaeEThe4Pn0TImZKNgosab/0t6kBpD1rem7WNDXsG0klAHZzT
	EcBcin44kCdn8wVp2o2f4pFbEQwjQOCAWGFbPFWYKoksCdXhuZZEVphMR9nIn8kGUDU1wnd+8N0
	E4nNh5Qhqw9YBWOFhh02DXds9AlsmVTeW890Muq44B0OvHK4XREf75e/uzWJAJkY3cuP
X-Google-Smtp-Source: AGHT+IFjFDPJlayCrRfWc9DvJXqh3dkzjLFvxTRqPgCdZj4Esjh95caHOKAZO16V6xVZyk1IxO0I0g==
X-Received: by 2002:a17:903:984:b0:234:9497:69e3 with SMTP id d9443c01a7336-23c9105c63amr1095985ad.25.1751663598333;
        Fri, 04 Jul 2025 14:13:18 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8457b2cesm26689035ad.157.2025.07.04.14.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 14:13:17 -0700 (PDT)
Message-ID: <e43c25b451395edff0886201ad3358acd9670eda.camel@gmail.com>
Subject: Re: [syzbot] [bpf?] WARNING in reg_bounds_sanity_check
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: syzbot <syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com>, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org, 	sdf@fomichev.me,
 song@kernel.org, syzkaller-bugs@googlegroups.com, 	yonghong.song@linux.dev
Date: Fri, 04 Jul 2025 14:13:15 -0700
In-Reply-To: <df2cdc5f4fa16a4e3e08e6a997af3722f3673d38.camel@gmail.com>
References: <68649190.a70a0220.3b7e22.20e8.GAE@google.com>
		 <aGa3iOI1IgGuPDYV@Tunnel>
		 <865f2345eaa61afbd26d9de0917e3b1d887c647d.camel@gmail.com>
		 <aGgL_g3wA2w3yRrG@mail.gmail.com>
	 <df2cdc5f4fa16a4e3e08e6a997af3722f3673d38.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-07-04 at 10:26 -0700, Eduard Zingerman wrote:
> On Fri, 2025-07-04 at 19:14 +0200, Paul Chaignon wrote:
> > On Thu, Jul 03, 2025 at 11:54:27AM -0700, Eduard Zingerman wrote:

[...]

> > > I think is_branch_taken() modification should not be too complicated.
> > > For JSET it only checks tnum, but does not take ranges into account.
> > > Reasoning about ranges is something along the lines:
> > > - for unsigned range a =3D b & CONST -> a is in [b_min & CONST, b_max=
 & CONST];
> > > - for signed ranged same thing, but consider two unsigned sub-ranges;
> > > - for non CONST cases, I think same reasoning can apply, but more
> > >   min/max combinations need to be explored.
> > > - then check if zero is a member or 'a' range.
> > >=20
> > > Wdyt?
> >=20
> > I might be missing something, but I'm not sure that works. For the
> > unsigned range, if we have b & 0x2 with b in [2; 10], then we'd end up
> > with a in [2; 2] and would conclude that the jump is never taken. But
> > b=3D8 proves us wrong.
>=20
> I see, what is really needed is an 'or' joined mask of all 'b' values.
> I need to think how that can be obtained (or approximated).

I think the mask can be computed as in or_range() function at the
bottom of the email. This gives the following algorithm, if only
unsigned range is considered:

- assume prediction is needed for "if a & b goto ..."
- bits that may be set in 'a' are or_range(a_min, a_max)
- bits that may be set in 'b' are or_range(b_min, b_max)
- if computed bit masks intersect: both branches are possible
- otherwise only false branch is possible.

Wdyt?

[...]

---

#include <stdint.h>
#include <stdio.h>

static uint64_t or_range(uint64_t lo, uint64_t hi)
{
  uint64_t m;
  uint32_t i;

  m =3D hi;
  i =3D 0;
  while (lo !=3D hi) {
    m |=3D 1lu << i;
    lo >>=3D 1;
    hi >>=3D 1;
    i++;
  }
  return m;
}

static uint64_t or_range_simple(uint64_t lo, uint64_t hi)
{
  uint64_t m =3D 0;
  uint64_t v =3D 0;

  for (v =3D lo; v <=3D hi; v++)
    m |=3D v;
  return m;
}

int main(int argc, char *argv[])
{
  int max =3D 0x1000;
  for (int lo =3D 0; lo < max; lo++) {
    for (int hi =3D lo; hi < max; hi++) {
      uint64_t expected =3D or_range_simple(lo, hi);
      uint64_t result =3D or_range(lo, hi);

      if (expected !=3D result) {
        printf("mismatch: %x..%x -> expecting %lx, result %lx\n",
               lo, hi, expected, result);
        return 1;
      }
    }
  }
  printf("all ok\n");
  return 0;
}

