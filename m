Return-Path: <bpf+bounces-52114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBEDA3E837
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 00:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392E13A4560
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 23:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C46266B72;
	Thu, 20 Feb 2025 23:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgZ5htHo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD0A1E9B01;
	Thu, 20 Feb 2025 23:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093485; cv=none; b=HI6QD6O8vndCl5Y5W7FZf2c24if7TKbk8rqAJnOs9HnTl266jtzTj3onINr+O1TLEAiaUtVwRYwSw5BtMFtVcDMwm/Iu/VbuQ9EcQeCnXndZH5703NziSehkCI5OhpKhWJDJbAlA4vfT3atPOH+ongUVs2v8W8k0gLs0L+urkug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093485; c=relaxed/simple;
	bh=kwkDA91WNx1hJwv0tU5mATRh9LuWrnMoNtvfhgBqVjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egKRqii2C9ZF0/7v0PobmkQw9caqvvRBaFRKzcBOMs6en8nzNEbUo6cM2kiZGiHlOdlmdr+WrqhkJ22P5HR8Xualcebox6s64tKDg+CwsVCXSmuIni70Zw8bkCvVNtyCEojnPnFMxrVTbTsVCQ/71xcnBGvTwjy/tnQE+HIO9jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgZ5htHo; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d04932a36cso14164315ab.1;
        Thu, 20 Feb 2025 15:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740093483; x=1740698283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwkDA91WNx1hJwv0tU5mATRh9LuWrnMoNtvfhgBqVjw=;
        b=UgZ5htHopVif7IRbUaTAG8GmVDZYnwKtDcKCFSV1NJPoQKSlj95jGscs82T7+Px5r0
         uS7A0OmJYpbv4ZoBf23fgUZ6OUBT0MqTh3eJZs+szuHTrIge5Yhon/5zUh43ENTk6F2w
         iNd0TQ3w0g9emNA5iIYl/lFO9YMbJbu4hYQkz7SkqpV3FFkv9DCEVWnE0xP58ZYsTYck
         otwXmMib+EXneqiYJX6MSZRAtl4TAf80adKzrPHpG8YclWpKmEy3YLEGtsu+6ugTxlLZ
         1sAm/V5peTl4VshSIfWdJdaVY/DOvgQUHrYC1MVEI1raCVVQxTR1EDH9zHo3Bd1mEUzk
         otLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740093483; x=1740698283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwkDA91WNx1hJwv0tU5mATRh9LuWrnMoNtvfhgBqVjw=;
        b=jVSyT2y/+TCoOHxW8oUJDjDsbqcsAnA3Hx26Uv8DsaxRIvMBysXJyPeYgB1MlF84DJ
         TOye8rCoGyIeczCTWYMa+FN06l0SpTX1Nk1lMzAvgeK0/T0pjknET81U6ZqoIj7y2ACL
         kbi4Cx8KBke4CnBJtdCqQJdiak8Y7D9GwodrgJ82KgQ3iM1T2MXIzjM09HTNdnfjPKCo
         QXAHcdN4hDZPz42ESiBADtWpQ31sch5znHc1VAg8IlSXofPu3DX19toUTH7NMZZOSHCb
         WvTqyLqgBpRv2/4+vuRK5ZIv9NsSTecGbzwmujmLLnUXce84Lyn44GbopH5vhQyPu0tR
         a8Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUFx6AnF1ri9epKt9olfXofFl4D6Mu1TWIl9Nu/JHOrcrAm0QJKWPp++C5i9C74n259NDE=@vger.kernel.org, AJvYcCUeUh55CnJmwn0eUGVOy/sr/4AFae+YrSb1o7TTX7aHvXX+YAJPP+953cnAGdqrGUaxPe73ajEI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4dp/+tQ0sBh2q1yvNHuX/O7kbbd+MM7Qc13n46I4Ifpdj7srl
	WI78fjxitr6KSjvjGNqpQtOTr9PunSi838XasEakuCuaprdyVsFECAW6wYtu0zwFjMzYsXmKB9a
	Z6TlJIQOucqbFd61+Xzo5isx4C/4=
X-Gm-Gg: ASbGnct7VbiNpWw2EhfvmfZZ3PeazTZv0P7GS8bIZaasWtLqFnB/UlYyweTIWcNO52o
	o3nyiwzhf3qFC6Rf3iUzGkfRngtwKRRn+YPejn4UlD9i6Ixr1/Z+2YoMmuG5Gyuebr4EI+KY=
X-Google-Smtp-Source: AGHT+IHfTFE+H0VF0wwBzQ8FtsfRVw8uONb+h+M1VmzYS1kQ6StUAi76egFtamcAe+SYCS1OSWq441Qp+uK2j6JW1ik=
X-Received: by 2002:a05:6e02:20cd:b0:3cf:ceac:37e1 with SMTP id
 e9e14a558f8ab-3d2cae8a97amr9033985ab.11.1740093482944; Thu, 20 Feb 2025
 15:18:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220072940.99994-1-kerneljasonxing@gmail.com>
 <67b74b0ca099e_261ab62945f@willemb.c.googlers.com.notmuch> <04bfac2e-e28d-45eb-a715-59ac4b58aca8@linux.dev>
In-Reply-To: <04bfac2e-e28d-45eb-a715-59ac4b58aca8@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 21 Feb 2025 07:17:26 +0800
X-Gm-Features: AWEUYZm9VUr1NqLHB7c5tfdlseTZ3JXSYJHGtVxYnguB1w-U9ijKk_E375kb96c
Message-ID: <CAL+tcoCK1H0-gV4Vi0=gCmq8QoDLtihFijbsspODcprh3Dbo3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v13 00/12] net-timestamp: bpf extension to equip
 applications transparently
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 7:02=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/20/25 7:32 AM, Willem de Bruijn wrote:
> > Jason Xing wrote:
> >> "Timestamping is key to debugging network stack latency. With
> >> SO_TIMESTAMPING, bugs that are otherwise incorrectly assumed to be
> >> network issues can be attributed to the kernel." This is extracted
> >> from the talk "SO_TIMESTAMPING: Powering Fleetwide RPC Monitoring"
> >> addressed by Willem de Bruijn at netdevconf 0x17).
> >>
> >> There are a few areas that need optimization with the consideration of
> >> easier use and less performance impact, which I highlighted and mainly
> >> discussed at netconf 2024 with Willem de Bruijn and John Fastabend:
> >> uAPI compatibility, extra system call overhead, and the need for
> >> application modification. I initially managed to solve these issues
> >> by writing a kernel module that hooks various key functions. However,
> >> this approach is not suitable for the next kernel release. Therefore,
> >> a BPF extension was proposed. During recent period, Martin KaFai Lau
> >> provides invaluable suggestions about BPF along the way. Many thanks
> >> here!
> >>
> >> This series adds the BPF networking timestamping infrastructure throug=
h
> >> reusing most of the tx timestamping callback that is currently enabled
> >> by the SO_TIMESTAMPING.. This series also adds TX timestamping support
> >> for TCP. The RX timestamping and UDP support will be added in the futu=
re.
>
> Thanks for working on this BPF feature. Applied.

Thanks Martin for sharing invaluable and precious knowledge on BPF design !=
!!
Thanks Willem for great effort on suggesting from the insightful
perspective of the networking area !!!

>
> > This series addresses all my feedback.
> >
> > The timestamping patches all have my Reviewed-by.
>
> Thanks to Willem and other reviewers for their input in this long thread =
across
> many revisions.

Thanks everyone from the bottom of my heart :)

Thanks,
Jason

