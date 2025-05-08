Return-Path: <bpf+bounces-57759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A78AAFB5C
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 15:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0538171DF2
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 13:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2FD2AD20;
	Thu,  8 May 2025 13:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIvhZg7e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A94222C35C;
	Thu,  8 May 2025 13:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746711074; cv=none; b=QGQaAltZM0rB2PHxwOMyd9kkhQ3YK40nYOv7yApakeTb4GNkrF4rdwOkWeTACNNjkW4gOuXHfxREc3zG766tXhw/tYwMLy3P/478sLX4FipTiKkjP84fu095NmT3GfPUa1Un0APlWXheU/Mx0Tc9/zSuJeaNd5Rq9JlpG7AEx/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746711074; c=relaxed/simple;
	bh=cVo2ypHOoBcnxAxuinY99VdUGeiAKvhMoFre9aBsPLI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=OzbQxLW7kCp/TiKQTqvS5FEe9jsmhHR1QN0zLkk1NRrvm6lTZkzRp2T3URvLpHhECKvYYha9gOTIZXtbKRjvekZ0j7A0EaYtMyqZUjVEvCMvLQUl61TYWNgWjSg1vf9zgG7rA/2CWf31xKWkejLqO8dFkouNyYZqKBPk3iRLYgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIvhZg7e; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c560c55bc1so119686685a.1;
        Thu, 08 May 2025 06:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746711072; x=1747315872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6qNFLQQGiatAczOdvaBp3/joWlyqexZCdKVh4bDNGc=;
        b=KIvhZg7e8qt59XG6mT2exDW+Ftzr1eq+LfOX/BI+b6ztdJJyMkWPZOd3GW1OKg7N66
         UYlhgcy+4bIgqdb9qfob9YlHjH32pkYSBWpVDlUdn8i9NPXLCh736o4/we/hNez+l9HR
         ofWXXzIjfyyOfeKkaYyOBxkOtkhq/mLw9c2ua3uwSmcnDwlmueHinOKy4zxFKiKn+3zg
         ROW/+KGovWmc8Qe/c16dkJftM4T8f9mi3olpvu4ulNiYeWBwSfHhxO8fxEr+Tf7dq+nS
         I31pdVOAIXe2JldhS6PAlL9S4ZHWsiMt3pYhZUzfKa4sc/UbuVwDbCmH6yDGjHnA2n2L
         3Asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746711072; x=1747315872;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J6qNFLQQGiatAczOdvaBp3/joWlyqexZCdKVh4bDNGc=;
        b=DlzKKvYHRfPOA619ezqbbOM5LN6s9UxcCD37hrfEmf7Z9joAmvUNf8bpXNudphCgN6
         KAT0wzA3ku8DXD2v9wIDWblqBZ2RKCcagtKKVDq4MHvqN6F+vXXBw8L0W/QBx1kXxQ8U
         HbOh4G3IiSBJb0EGf2XZ1qOvDrTUqkMgj8BSSM/qsnj6szt54e1yqG8bO9rJqZRk7jTt
         Xf+YsTIeLniPmWR09BoS4HE/Sn1zDaTK52RcfXFpyh8tuGv0M97+00uVCU1Y1h81A0rV
         49pA1SYfDIZKkGCs8sxckdW9Ap/7PUMKs+J5qP4nYFnHEDTflCWqLlH+fQsvoX6Qano2
         2/iA==
X-Forwarded-Encrypted: i=1; AJvYcCV4m9TfM293A7ndIMk+0xtB+6XO1F1KDOpHWZCjW2cC4sD/tKIHOqVkNdGAyAfT/bKY4xc=@vger.kernel.org, AJvYcCWW0XEF9l86pigYsORQVn7cAuz+E0Q7G6q2CVuAmyz9UuzEhNN9P+EZNDKPpja59+heUcBmoMrO4eTkhr5y@vger.kernel.org, AJvYcCWWs6L28I/FR54ZYN3GqM5w5LDNBo9tduc2FFPmla7/DRFDO/0u+cnK9QAfIGB1S+Xt95OKo48u@vger.kernel.org
X-Gm-Message-State: AOJu0YymOzaYZBAEF+AoIGWL3jwYgoIdf6riqh/lwoUFQQb9DSrhklek
	im0vJdApnbJR4l9ws/dj28fjggKpp2HlELELwtiy7Ojc0ir+QEsD
X-Gm-Gg: ASbGncsfCRSyCPnm3omzrfVfq+sFZj9TZGrKoCJBMud3TnN51j++OIUxlJn1go1Y+1O
	ZzoKEvv0k9agXL+FOc8DoM30qlY/kOmjHPIRQ86Zg9zhvEg/jNNgGa/QnhnWgoB2YFkummOyB4O
	WpOIklIGS6pjwOjxtQuaCTr4AC5VjhjG8pXkX2CZPgCq0l2dxYEM9BTvF7pNmQj+qhF+qPijREv
	lkEIobwSSwWxq+sPTiSWAvDH3qzC6wOqXSEU3KQw6U446L5XJ7CkoaL0/AK+6MWyNYNB28g9URf
	pT94lFJ3mbgAFmg8RmsTbMXDZxzjjrF9hxj9yK3ByIm1l8diO3Ck2XSvhF+LAD2QwdzddVnBX60
	VxZozHj837aHnkal3yesB
X-Google-Smtp-Source: AGHT+IEsVf9XFVh/uB8BMCYEqxrucJwShP06Ahgp4HpfPLdR2JLsnAvnAX2SJeygjN6BPt8dQeT+0w==
X-Received: by 2002:a05:620a:c4c:b0:7c5:43c2:a908 with SMTP id af79cd13be357-7caf736d3ffmr1114654385a.6.1746711072083;
        Thu, 08 May 2025 06:31:12 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7caf7528cdfsm355213785a.31.2025.05.08.06.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 06:31:11 -0700 (PDT)
Date: Thu, 08 May 2025 09:31:11 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jon Kohler <jon@nutanix.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "ast@kernel.org" <ast@kernel.org>, 
 "daniel@iogearbox.net" <daniel@iogearbox.net>, 
 "davem@davemloft.net" <davem@davemloft.net>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 "hawk@kernel.org" <hawk@kernel.org>, 
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 open list <linux-kernel@vger.kernel.org>
Message-ID: <681cb21f4616e_2574d5294b3@willemb.c.googlers.com.notmuch>
In-Reply-To: <CF84F28E-C3D0-44C0-8540-53E184BA1F79@nutanix.com>
References: <20250506145530.2877229-1-jon@nutanix.com>
 <20250506145530.2877229-2-jon@nutanix.com>
 <681bc5f4b261e_20dc6429482@willemb.c.googlers.com.notmuch>
 <CF84F28E-C3D0-44C0-8540-53E184BA1F79@nutanix.com>
Subject: Re: [PATCH net-next 1/4] tun: rcu_deference xdp_prog only once per
 batch
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jon Kohler wrote:
> =

> =

> > On May 7, 2025, at 4:43=E2=80=AFPM, Willem de Bruijn <willemdebruijn.=
kernel@gmail.com> wrote:
> > =

> > !-------------------------------------------------------------------|=

> >  CAUTION: External Email
> > =

> > |-------------------------------------------------------------------!=

> > =

> > Jon Kohler wrote:
> >> Hoist rcu_dereference(tun->xdp_prog) out of tun_xdp_one, so that
> >> rcu_deference is called once during batch processing.
> > =

> > I'm skeptical that this does anything.
> > =

> > The compiler can inline tun_xdp_one and indeed seems to do so. And
> > then it can cache the read in a register if that is the best use of
> > a register.
> =

> The thought here is that if a compiler decided to not-inline tun_xdp_on=
e
> (perhaps it grew to big, or the compiler was being sassy), that the int=
ent
> would simply be that this wants to be called once-and-only-once. This
> change just makes that intent more clear, and is a nice little cleanup.=

> =

> I=E2=80=99ve got a series that stacks on top of this that enables multi=
-buffer support
> and I can keep an eye on if that gets inlined or not.

That will only give you one outcome with a specific compiler, platform
and build configuration.

I would just drop this and let the compiler handle such optimizations.=

