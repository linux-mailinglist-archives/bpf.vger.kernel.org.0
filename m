Return-Path: <bpf+bounces-62568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F64AFBE3F
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 00:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3C248031F
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 22:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8276A28751C;
	Mon,  7 Jul 2025 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVTbBXgO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBB1800;
	Mon,  7 Jul 2025 22:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751927416; cv=none; b=aYB8k6SRmfCNnYdyX0vodNlt/Vkrp3Yj94vyvaJhuuMBiFz67FrZvPQU5kuB8l/8pJhpf47xdAZpG/rANXj8sk9C4jCz70AiH8pgJnGBFZqdcCNlgVkHESkglbeY97diKujb36ZxLs8ZshPOv+I/iQ3p47/+/4WnCYzoD1LRVtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751927416; c=relaxed/simple;
	bh=n/qlHRTZ75H/a48PwtdzLEoZbFCMammRCYqg3lcrv2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5O2icHaDQe3nTiG75llaqZuwEcWT2mMeMQDM0/b0id+aPXxaKI2yWYBmIBg6fjiCqrWSSgv6rwjy04j8XiUnaXGIvdHMZE9n4Hza25aUmilwiLpC6XtJeHktSKg1ShDdd3dKiRyS87E1B+4RVkY1BaTYM2jo46H36KoWsI8uSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVTbBXgO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450cf214200so27638015e9.1;
        Mon, 07 Jul 2025 15:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751927412; x=1752532212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zEFz/bgHfmwoyPjkuXzwFcQmAm/NUFdt3vHCXoJuaSs=;
        b=gVTbBXgOSlE1FWR8XkexHFxNEqBcAMwaUw7fQ76ys6a5sK/gkRIfXQdT7WzKv7IBNt
         Kj8mgDlr3OESbGmWGRAv00tizkYbjzXJh4AWIiAzBul3J/6RN1yS09S1EyuJouyNJhJm
         eqXhb6RCZvP8ZriF81Kd7tYIUxEohqm0eZUhaUHYZXwe7gzpbRu3MsVsfM2bws4Ujmp0
         NCKscq7I3TCo2Gc/XdIU9ezz8l/xYCK0Z/cGNypd9q9hKHroRFFesZDaD8WaVtb3nyKA
         xSHF9CX6rg0BQJ1uM8v19c+g085uXTRx1ZxiCl3B8qFqu/R4EYiRQWyGq7981x9VwJsG
         FVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751927412; x=1752532212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEFz/bgHfmwoyPjkuXzwFcQmAm/NUFdt3vHCXoJuaSs=;
        b=UCdOXledMMlhA1LYXaH4RXdDG9fDgmD8+CqSPPu1hNZ6u2R87+cai3RtFs6mJkhsRC
         RV9DMBouONgmU1UTj1XNat5wfU5B5dUNSeLYatK91X0xLXb9eQ83prBDGObhIC5MWoVB
         zO0K//zKpAXlbyWgTSCZlU5HGCjAD1Se22oeZDf3TIsjtjRmqSS84kSDkzRzv4SsJDee
         ZsGUeAJM4g91eaGhxpHsgVnNsCSrKAThk8EX4Z9uPYm7jTUdjMn0IprE8+PfaYaKlqia
         W3u3u4xb9j4giezMC8Eoj4hTYen7zkYD+QucouOLtlF5MxC4rswoV+e8YVrpTMNmGWIp
         8xow==
X-Forwarded-Encrypted: i=1; AJvYcCUbY5QgGyWxHKE4nFIKIL7A+RSqDS4g4a6QvTcpMMrSh/OThrmcRKvrNCXZP70ukeVUbuuPQDZC@vger.kernel.org, AJvYcCUd1i7tb2usS6rwMa1KSP0wIHCeZjfBl4vlray1hGo+xaME2NltJ/84ydfVAYjRm75OigoUGdIqVthpo2uF@vger.kernel.org, AJvYcCWEHg7CBTvFK/W5bmYYMn2Gfjr+IhDuQCt8SADyLm7cubh2W17NYeLrGISgvH/meGGwH5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw49ciFereAj7EaOXzNabY2ffM2Xw4xna9egD6QowaJkEklp/Fe
	TvCWYsimrS2W0FxcH70e77tWZG+O5jzsy7wulyzngq8f4YttKaj8qgm8
X-Gm-Gg: ASbGncsrXB8pyePu1NBBfKvSOaheEMUNO34EZVg4lM+jCtbIQyu7kUlewpRdNJ3f+gg
	O5IkGWcyhiiV3FuIGXmqtl/AQ+mKA5/aXFkn8FSY/VoUEyfNvYaaMkTbO736XxvyicB1WUCylnL
	JA+1NXH73vewrLL26/BmzZg31alj8x3Ca649mntVaFGFoEi+TqMvciw7TwKkc7hklvwoB9Sf9x+
	fgWBOyIW3CjPUBLPiLpFucw7+pnTJOXxTQRYsebgO8eSu+bTLbguIgw7nWJTr3FuipogXtRY835
	G9P1SopAZGOD7Uz0kOyooHO9T6wVmfMdRB+KItFCje16nXfYBGUuvQWlBVgILMx8j9fgGiRoQ5Q
	5o0TjWOdhVhL5KxPkBNx5v9JopEr/XctN3u16RRqp5CUwA7AejxZiZ8LgfZIy
X-Google-Smtp-Source: AGHT+IFoutiUWetGy1YNhenkO17nBMKVYaqDf5EVl3PadIgE92GhfhTiWV4f0mWKtdpRsNq7RQ6yEA==
X-Received: by 2002:a05:600c:8416:b0:450:d4a6:799d with SMTP id 5b1f17b1804b1-454b306b0c9mr120056765e9.7.1751927411292;
        Mon, 07 Jul 2025 15:30:11 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f536999e2663c8dd.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f536:999e:2663:c8dd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd3d25e4sm4154125e9.26.2025.07.07.15.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 15:30:10 -0700 (PDT)
Date: Tue, 8 Jul 2025 00:30:08 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: syzbot <syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com>,
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
	martin.lau@linux.dev, netdev@vger.kernel.org, sdf@fomichev.me,
	song@kernel.org, syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] WARNING in reg_bounds_sanity_check
Message-ID: <aGxKcF2Ceany8q7W@mail.gmail.com>
References: <68649190.a70a0220.3b7e22.20e8.GAE@google.com>
 <aGa3iOI1IgGuPDYV@Tunnel>
 <865f2345eaa61afbd26d9de0917e3b1d887c647d.camel@gmail.com>
 <aGgL_g3wA2w3yRrG@mail.gmail.com>
 <df2cdc5f4fa16a4e3e08e6a997af3722f3673d38.camel@gmail.com>
 <e43c25b451395edff0886201ad3358acd9670eda.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e43c25b451395edff0886201ad3358acd9670eda.camel@gmail.com>

On Fri, Jul 04, 2025 at 02:13:15PM -0700, Eduard Zingerman wrote:
> On Fri, 2025-07-04 at 10:26 -0700, Eduard Zingerman wrote:
> > On Fri, 2025-07-04 at 19:14 +0200, Paul Chaignon wrote:
> > > On Thu, Jul 03, 2025 at 11:54:27AM -0700, Eduard Zingerman wrote:
> 
> [...]
> 
> > > > I think is_branch_taken() modification should not be too complicated.
> > > > For JSET it only checks tnum, but does not take ranges into account.
> > > > Reasoning about ranges is something along the lines:
> > > > - for unsigned range a = b & CONST -> a is in [b_min & CONST, b_max & CONST];
> > > > - for signed ranged same thing, but consider two unsigned sub-ranges;
> > > > - for non CONST cases, I think same reasoning can apply, but more
> > > >   min/max combinations need to be explored.
> > > > - then check if zero is a member or 'a' range.
> > > > 
> > > > Wdyt?
> > > 
> > > I might be missing something, but I'm not sure that works. For the
> > > unsigned range, if we have b & 0x2 with b in [2; 10], then we'd end up
> > > with a in [2; 2] and would conclude that the jump is never taken. But
> > > b=8 proves us wrong.
> > 
> > I see, what is really needed is an 'or' joined mask of all 'b' values.
> > I need to think how that can be obtained (or approximated).
> 
> I think the mask can be computed as in or_range() function at the
> bottom of the email. This gives the following algorithm, if only
> unsigned range is considered:
> 
> - assume prediction is needed for "if a & b goto ..."
> - bits that may be set in 'a' are or_range(a_min, a_max)
> - bits that may be set in 'b' are or_range(b_min, b_max)
> - if computed bit masks intersect: both branches are possible
> - otherwise only false branch is possible.
> 
> Wdyt?

This is really nice! I think we can extend it to detect some
always-true branches as well, and thus handle the initial case reported
by syzbot.

- if a_min == 0: we don't deduce anything
- bits that may be set in 'a' are: possible_a = or_range(a_min, a_max)
- bits that are always set in 'b' are: always_b = b_value & ~b_mask
- if possible_a & always_b == possible_a: only true branch is possible
- otherwise, we can't deduce anything

For BPF_X case, we probably want to also check the reverse with
possible_b & always_a.

---

#include <stdint.h>
#include <stdio.h>
#include <stdbool.h>

static uint64_t or_range(uint64_t lo, uint64_t hi)
{
  uint64_t m;
  uint32_t i;

  m = hi;
  i = 0;
  while (lo != hi) {
    m |= 1lu << i;
    lo >>= 1;
    hi >>= 1;
    i++;
  }
  return m;
}

static bool always_matches(uint64_t lo, uint64_t hi, uint64_t mask)
{
  uint64_t possible_bits = or_range(lo, hi);
  return possible_bits & mask == possible_bits;
}

static bool always_matches_naive(uint64_t lo, uint64_t hi, uint64_t mask)
{
  uint64_t v = 0;

  for (v = lo; v <= hi; v++) {
    if (!(v & mask)) {
      return false;
    }
  }
  return true;
}

int main(int argc, char *argv[])
{
  int max = 0x300;

  for (int mask = 0; mask < max; mask++) {
    for (int lo = 1; lo < max; lo++) {
      for (int hi = lo; hi < max; hi++) {
        bool expected = always_matches_naive(lo, hi, mask);
        bool result = always_matches(lo, hi, mask);

        if (result == true && expected == false) {
          printf("mismatch: %x..%x & %x -> expecting %d, result %d\n",
                 lo, hi, mask, expected, result);
          return 1;
        }
      }
    }
  }
  printf("all ok\n");
  return 0;
}


