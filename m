Return-Path: <bpf+bounces-74420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C67C58DA3
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 17:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF62235A8D3
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 16:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33172FBE03;
	Thu, 13 Nov 2025 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdH2pb97"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49F335A137
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050182; cv=none; b=GlU+JP+bi9d9XlZh56V5MaosdhNqmfvkkVezBOujhu75SGoIpmq/4nla8wbAoioBdB+qt0c+D2wA8o3j/As4Rlc90sNP3cYfJQtpckW4rA2bshY2I54XCJPdDRVwMBvBBdm79RYTb8CNgxX+VH7sd0iubpJW1ZrUASbW5IelYVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050182; c=relaxed/simple;
	bh=leiM8YtwCsCGMKaEKB99YhbeDEVEPb2LPcTIg+dEOcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtGkflyXHXqBpfELLkQu9pOjA0pX29y/l8Mf5AjvTsuBKwGXlqaiSyF8e94W7JfpGthI66kp8vJjy2MnIYH+R7irSAAIGwmy19v24AvdEembAmlEE4o9a7yjB6dBmJhI9w7ugW72wbHGdwPtEYDDH26mL4n7/6S/sOU/WzLNP9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdH2pb97; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b3720e58eso895761f8f.3
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 08:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763050179; x=1763654979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leiM8YtwCsCGMKaEKB99YhbeDEVEPb2LPcTIg+dEOcc=;
        b=TdH2pb97dE5a6+INualThQ4HxiwQViA6L29N3LfKOyz1bKCTqGTZXzOhAcLJmE4TEY
         gdG2pqqi0lJnT6lc2+VgMBqXqActK/wx8AOsuFsa8fbHnv+sBPEX/TEy8KdjPPQWMH+4
         LWzmJKGG81uDbf8nQHGGFlurKV/BTpf6rHyPx3iFaCd+XVeBROlTT3jMVmWIWfqZo21O
         tkjl1mnBZRk/2DwxS0rA3FmCTTsReKJHmpx61WYS4e2TxsskxUACngXwe6xAYyxyATFa
         6Tyxo4qdMkjDMr7ULBh2chydi51ptoks/qgkNrcxCzyNmKjnCeWb56DKasbVmomdak8P
         Mb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763050179; x=1763654979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=leiM8YtwCsCGMKaEKB99YhbeDEVEPb2LPcTIg+dEOcc=;
        b=aYKRcFMLjdM4JXX2k2mHWgh3imHBBzD9EHcFbfb/Tgbila7ooW0xO8iLX+a7yWTx9E
         uTojFkG7SBy6GVcOKZSsPlR5IYXjt5OYWeMYQ9yW9CEgRKzzEoTMwV+KSyPOjQBRbh7w
         3L7wU+vpBiNjee4TYpI8jH7obyIiz9mN2o44jEV3WKuaqbNj/sEqxjLmXcaFiV09ynGL
         zyKhMTGKUfozd3ZaPdHbCjZ8EFWHJdjVwbXNeAJ7L8TLotr4uUCwNWc0Pn7cY4PlR5Pk
         vGC8v4qxFxxNT0Fu9jmBZJF4kKa1bo7dFVdwaU+2Fv5UvqGQUOp9Q0kHaT2k7w4t1K3x
         dQRg==
X-Forwarded-Encrypted: i=1; AJvYcCUJmZ8pd6pAw8LznMejcwiXmEsCjp0PIj7Rgc2LvbY/GGAQ7rOhBjij4Bfl4pme8F5iLjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxdOVXFvYXyoUPpA5BED2xy2UgazYdYn3hQZ0EOjSz9HR14QTA
	T+/g/zVMnStS361+OJCYd9Aqhodd8Otuhn7FHykpGi6MOW6xAI51vi8kGpoUls3HJplzJHuUt3d
	yUSUGJdd40fDqV1D6fLKfFDQuDwhePrg=
X-Gm-Gg: ASbGncsIHTo8Dx2lv4+2V5DzQvw8Hp9uUurgarq+WCUVvTD6Vit1lcC3rvaOM9K3jZj
	HwxR5B3ZNpwosXgZTPMawEVDRtCIqzwslwHFC4cepd0LiCQMZa/zte6wfOZoe6wq5uwD8pMcAM4
	GsboVzTNwjoue1Ixxrl+yVi99F+T2Dt41Lt1xhQsdTeEXKRk8eqg2LfGJYZFrtlQaetqD4IcMNr
	VperzEBBb9jT58SqEEqAdbckXSDSZaFhul4oLKE4Ma5BYurgH0fYXzVePueFUw/rXDHEpf8GajV
X-Google-Smtp-Source: AGHT+IG+F1mcCMGQMp14f/n/qz+xTQjvR7aUPt86aJLXcB0TBvXknBCKfoqX4FnzEI39kpTXgxDUVRClureW5+KjBH0=
X-Received: by 2002:a05:6000:3106:b0:3f7:b7ac:f3d2 with SMTP id
 ffacd0b85a97d-42b4bdb947amr5898503f8f.43.1763050178696; Thu, 13 Nov 2025
 08:09:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <998304ddd050ef81ce6281ebb88130e836c07fc3.camel@gmail.com>
 <20251110151844.3630052-2-martin.teichmann@xfel.eu> <4952b7bf8a0b50352b31bee7ddf89e7809101af6.camel@gmail.com>
 <745490756.25826958.1763034360662.JavaMail.zimbra@xfel.eu>
In-Reply-To: <745490756.25826958.1763034360662.JavaMail.zimbra@xfel.eu>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 13 Nov 2025 08:09:25 -0800
X-Gm-Features: AWmQ_bmIn_GlpVynWKX53_sHtTRyVyjx97kof__yjIr_80LxtS7o1vubSDJOrTs
Message-ID: <CAADnVQ+sYVgMFhdA6agQmOXBwpJAss4L+w-K-QJ-22FHae-hEg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/2] bpf: properly verify tail call behavior
To: "Teichmann, Martin" <martin.teichmann@xfel.eu>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, ast <ast@kernel.org>, 
	andrii <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 3:46=E2=80=AFAM Teichmann, Martin
<martin.teichmann@xfel.eu> wrote:
>
> Hi Eduard, Hi List,
>
> sorry for the late response.
>
> > This is a clever hack and I like it, but let's not do that.
> > It is going to be a footgun if e.g. someone would use
> > bpf_insn_successors() to build intra-procedural CFG.
>
> I appreciate the effort you've put into your solution. However, I feel th=
at we might be leaning towards a YAGNI (You Ain't Gonna Need It) situation =
here. Sure, if somebody wants to do something like your CFG, my "hack" migh=
t pose problems. But what if not? In that case, your proposed solution just=
 leads to additional complexity and unused code.

Disagree. Please do what Eduard suggested.

> In line with the tradition of the Linux kernel of keeping patches small, =
I can extract my three lines and the corresponding test, allowing us to pro=
ceed with my patch as a bug fix. You can then apply your adjustments for th=
e stack liveness issue in your preferred manner.

that's not how it works. Please address the feedback.

pw-bot: cr

