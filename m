Return-Path: <bpf+bounces-78259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55713D0679C
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 23:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B72DA3025A76
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 22:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C643382D0;
	Thu,  8 Jan 2026 22:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EazdywGP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1943D334361
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 22:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767912617; cv=pass; b=UPYtAtpW0jCAbfYdbzdILnU3xuS6aoXilXOv7jKTwE0l5HCs/NiEuPqTqDqu/z8iC2FerkAys0UOInCPBFKtkTibiFiRiAfdoajdkPoXl9ZkIgFfiQznDu9j0L69HiHxy6zUb9DesYtrlYo808mHVqz/EAyh8ClATk6oiBeiAQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767912617; c=relaxed/simple;
	bh=0Kg9b2/WsUIMEqmGuRHA5a4yLHhV5XKlV8sTuaMp9aM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYe3CyONpoBf95HXbUKTMzf2/5xUIOtKdZ+DQth7WXwpvisXqxTJNCOCWqLtwT7nM3RZ55CbfeSJ0/xQOHfqhZ172r410yFngesAZ/RyTbXNxz3yV6n0pULDB1mxIUv3UWkB7t90L0iRxvtZur8EyQGJTQ+2oeLF/GH2cvk7Rfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EazdywGP; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4edb8d6e98aso182061cf.0
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 14:50:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767912613; cv=none;
        d=google.com; s=arc-20240605;
        b=VpeQh9MEVZSkzdAUaAI69nJPYUczj89mBup27Ci+Hcdh1/VjbrLJpEyPBRwoA3LX64
         jWlO9UccHWHFCdlxIh2PcciOCVADlqpSlGzdAAl93Y6nAnqm4vuiePSYPyDFFpmP7udA
         fGeo0FG3HL8juBhfr7XoxZOR6AlfgXg/1Vv/qAn5Y6EB1JqEHYV37VyO0Cu+OcV+NkpM
         H8qQRn6/FMjL32wyp2ZruRyrUG1Vz/ipBVC/OtfhimvmqWU3zzLj1lPqYODPLyPpilD9
         /9FsbrsTuhUGG2hMmpJIhck+x4NxIOSLavNJv6akSyP+fbYosipRxq2g2CfE1JGJbZXL
         HaSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wseu+RuUn8NgZwFWIiGhlQzFjB8QZcJo0bXjL+h71eo=;
        fh=+CEECgjutxfvzHE3pBSBmwnePUpTHG1Wc9C9wioOgv0=;
        b=VvaV6nb4uffjc8sHjd3gne2hnY6HCb8JUk1RiJX5VPj9cX4gP1YUvk6b1M9r1tdV1r
         npUQxoG4WzDxqn5egksAg7TwXoMYkQHKn2JnBGVP7WsADClaClyntZQM5qIoArz3f3NK
         lF6bfoutd5QWZ8FIxvAwD3ZPDEnQtwYRvYW3oSazhytYwzs6QL9WLaAQzdD37xMcClzg
         Y+uY5im+/UOPOrgGzbpo7NVJZXArdd8CxwBpdA2H7dYLzPi78ixWM+TIWQyih5K9tw9r
         xxGzcYOjqnmDWQxi06E2OUfglTl3eofeZsDqE+8ypW9e8YHKZyp+IJ6CatcVUSRrPc99
         pUIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767912613; x=1768517413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wseu+RuUn8NgZwFWIiGhlQzFjB8QZcJo0bXjL+h71eo=;
        b=EazdywGPZDCXH3Fx5TCKx8lRPKR1YFKi2rVdJxp5TFEc9FPXgCHy4+KFLFNwGHIJJs
         MgHNdzGU30XBZ1gHL6jcB8RAcVWXfiGdoYbJDPT/CqaP2NI/yiTrIV1SNx0tyaZO4YXV
         zvkYL3UjcM9Z9Qf10f2eJdWOWTVNoySi2LyTw7UCfjNZxlGwaKLj4LgUzShVswoDMInM
         iDMUOmfSYe5ThtQoc6lXI5oOjrmKRbLm67kAwNWAZMg1esDPV1Al+Q0DnAb5EOEt7B1Z
         n2z9uIEFnyRVShloZtvQXCgoTvhZt3foz20FPgvtnC4XkJyMcEA6USyg1aQv2WE8QqnS
         bLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767912613; x=1768517413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wseu+RuUn8NgZwFWIiGhlQzFjB8QZcJo0bXjL+h71eo=;
        b=w65LD2YNH7Ep9d068yzr57v+HDJl3zqexfVLeeyP6UnIyNYmLq5Dl0uwcS1fQpRIBc
         aGwDq+6mn9D8xrQL0lB8zsfYLZTm9LSL5xfuoKy06h87pUUzQ12EZrs1/Scp//6wNqi9
         57DHOp1AHx72Sr80eDSNWp41/BTr3WXrlGjX9zKFbPwddvlh3p3nifENsLCtzP/kZYXV
         jQH80fgWISqjnJFfVg9z1sbir1n49V+cQkf0rFcEyypN8ERtNV8iEsKiEdnvHTt1BRdc
         tGRgB748ABQVln/rvyxjUEcShHWbABhGuyruqS+XWWT7xNvNROFZirUht079sgLy67hl
         Gj3A==
X-Forwarded-Encrypted: i=1; AJvYcCXCfjknv0PI1WH0vPNPLZd14auzP5PVbsqU01eMl2AJiaPSvo1qnM0MYp0wb+7lMyT1sY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXvWwAv/6kdpmiYK9RK0KRW1Z9F7Gj+HnXZ4Y2t7mqg6M0sMf1
	6HUB1Ph0sCd2dwgSc4qYG2LoVlTpTtHxxh0JiY/IBdRg8gEg0xrk5R/pnYWLB3gs7xgVzZF7YPa
	fgHMRVMkNK+F6bwSM6LJQo5qQrUxuyeveZ56DxexR
X-Gm-Gg: AY/fxX5khbD50gUP8dAQEWzibHl7cNeKP+Ghu9nl4isc6Sw4IAeTO7xdGn/PgwLB+bL
	ia/M3Snz1kXlY5+K5TnHZPr1uWMbnXsVKNa9Wsm5aUZx058R1WS0tiVfEtVX5NZq/qgExMs6dH5
	4fF3FVRywGAi1J6Mj0u+uviI9s54xEaeAVnpyH26AVk3rqG3txV4VGZh2ZOhWuWivxGLp5sZu16
	x11MN+LhsGlPNWR34w4yKNbpQh5IBXNBR99IxnjDXRsbO92JeSGjniCOJaiXSfO5o8WBxOTekvz
	ba88RcBCHtFKZ2ujkhU0b5mtvK5C9K6FIrhsM8eYJPg0UrTdqAEAk6MbvIo=
X-Received: by 2002:ac8:725a:0:b0:4ff:cb75:2a22 with SMTP id
 d75a77b69052e-4ffcbd0a84emr528911cf.3.1767912612694; Thu, 08 Jan 2026
 14:50:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108155816.36001-1-chia-yu.chang@nokia-bell-labs.com>
 <20260108155816.36001-2-chia-yu.chang@nokia-bell-labs.com>
 <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com> <CADVnQykyiM=qDoa_7zFhrZ4Q_D8FPN0_FhUn+k16cLHM9WBOCw@mail.gmail.com>
In-Reply-To: <CADVnQykyiM=qDoa_7zFhrZ4Q_D8FPN0_FhUn+k16cLHM9WBOCw@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 8 Jan 2026 17:49:55 -0500
X-Gm-Features: AQt7F2o6WroRcnLZsfsh5rQuai7Ltrdaj81MBXbeb_Nn4Vs-CAUHJkiKVn3RRPk
Message-ID: <CADVnQymHK0y_ALJ6obg60j+oUgjgpA8daaazin9hzO+-O6oRdA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/1] selftests/net: Add packetdrill packetdrill cases
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, edumazet@google.com, parav@nvidia.com, 
	linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org, 
	dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 5:47=E2=80=AFPM Neal Cardwell <ncardwell@google.com>=
 wrote:
>
> On Thu, Jan 8, 2026 at 5:46=E2=80=AFPM Neal Cardwell <ncardwell@google.co=
m> wrote:
> >
> > On Thu, Jan 8, 2026 at 10:58=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.=
com> wrote:
> > >
> > > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > >
> > > Linux Accurate ECN test sets using ACE counters and AccECN options to
> > > cover several scenarios: Connection teardown, different ACK condition=
s,
> > > counter wrapping, SACK space grabbing, fallback schemes, negotiation
> > > retransmission/reorder/loss, AccECN option drop/loss, different
> > > handshake reflectors, data with marking, and different sysctl values.
> > >
> > > Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > > Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > > Co-developed-by: Neal Cardwell <ncardwell@google.com>
> > > Signed-off-by: Neal Cardwell <ncardwell@google.com>
> > > ---

[apologies for the premature send due to accidental shift-of-focus...]

A third note:

(3) the patch title seems to have a typo; it is currently:
  selftests/net: Add packetdrill packetdrill cases

I would suggest something like:
  selftests/net: packetdrill: add TCP Accurate ECN cases

Thanks!
neal

