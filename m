Return-Path: <bpf+bounces-32150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1E790802A
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 02:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5911C212BA
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 00:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E017A138C;
	Fri, 14 Jun 2024 00:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHPc2rqs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F24383
	for <bpf@vger.kernel.org>; Fri, 14 Jun 2024 00:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718324771; cv=none; b=kW7Y4JN0Bqbf/iDSFJFYYr0xiy1LMlCKiIOWqP41JIdqEMvsIidYAxVZltwUcGni7Kc6E2BtCLw/rq+R6tm6LuqT9TSYsYdHxJ1jKnMrkNtz6mxzzmdvsMNmbxqv33fa6poWS9RAvbzcC+d6iYKOXBP1BBB1mN8+lqqUJ5U9lqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718324771; c=relaxed/simple;
	bh=otIxQWhU545pEGQsscl6JDj+UL4/Va46xqVVeAegnQk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BHn+KJwnMuLbN7eC/xFv2y6GGcwHYHqCQefvkXhH9vxZeC725QIoOfF/KiN96dzoIjFKrnR7fIhna9kfZ3EVgBPm/6LRH9zjKHk5Art+udlMpqoowMuQPzfvO7Ve8YBz0LoxPzUUjR2SKIxS+ET81iaBA4DV6PEMg3s7WeZ7jEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHPc2rqs; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-6fb2f398423so1091681a12.0
        for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 17:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718324769; x=1718929569; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u7glo9uA5+NIkIVm3+uPMg4GyScf7lUKCX9Qhf8CqiU=;
        b=WHPc2rqspDwiSxTN5NV6dm9gBRvjxnpA5pyXDT8UiSU4PEtbr2saLzQG3E4Gbh/4HS
         QSFRk2MNtLJYureApbUougXr+Hb6xf1hKa93wL5nNfuDnbkPhcRUOUYI+NCClbvCTGOt
         aFtLAbx2VKPtO4lScbPHcTwZjT5eWzZw8Oyrvh+XTapDK1EfUj16jByLzarblVMBU3IL
         0z9wioZezUFwsTtoZ6MXSfXwSsRKXC8ab4FvnKYCKYrrUOLbvC8DRUXsUfP80SjE1gZj
         V7/EfRA6TqFCHTDEHFCEF2cTCeuCyzX8EluKkNaHXhq4WgOPWpV5hC60N2v5q8D+56Kh
         1iMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718324769; x=1718929569;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u7glo9uA5+NIkIVm3+uPMg4GyScf7lUKCX9Qhf8CqiU=;
        b=sN55ThtkTKB4LpyiPqf7eTT73us/qL3vFt+MWy5x7ckN0VA/dhhBJ++mgM66SUDJac
         Gmss/3Gnk1QkSc99xc3pQ6r8G5wua+wNrvFhLDxqXKAcGAxA6RiId2Hl/EcYNmXcCTpp
         ReY3g63Uau+4JLz73Ot0VxsAzYLDa+5kCe3Gww/qZK3hm8dHX7SH6ivb1YXfeKMZBKgh
         Kamx/uPVFRwn8kgxO/tSo7ZdW2GDH/9HUvB7EifhtvC4kFzid0xIPG3ux7xPx9SRSZYF
         prFdcG8ArYII/b8nq97xVkh+fjPq3Epr+VmPFIIAZB7qoPbb6iZ9TgE6cneJ/8KMMTMx
         Je8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXccgpeafQOD1lAQ3UALWgRVYjC/rfAqA2MCtUs1hZcqcv6mFkTYZ27rHgngQTfHbcY7qihTMHycBe4wxcduLqRXJfy
X-Gm-Message-State: AOJu0YzDo3+VoIkuoipd3R913wJftygddmX4iJMDnH4yXwfJS/YM0BOA
	qk2vclBaHqz6a5cWh20FBwr7kOJWJtRFKAL/XHSYNn/55yZrPSSv
X-Google-Smtp-Source: AGHT+IFH7tLI0qadhUwHWWc+EnIbs3B8kIaFa81EBMIcvqA/RrM6SM8ZlptGtogkjMdv8p269q4URA==
X-Received: by 2002:a17:902:eccc:b0:1f7:5a6c:ae3e with SMTP id d9443c01a7336-1f8627e337dmr17944145ad.33.1718324769280;
        Thu, 13 Jun 2024 17:26:09 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f01774sm20338805ad.183.2024.06.13.17.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 17:26:08 -0700 (PDT)
Message-ID: <ae960343c20b56253c321160215496515e7f44dd.camel@gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/9] libbpf: split BTF relocation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, mcgrof@kernel.org, 
	masahiroy@kernel.org, nathan@kernel.org, mykolal@fb.com, dxu@dxuuu.xyz, 
	bpf@vger.kernel.org
Date: Thu, 13 Jun 2024 17:26:02 -0700
In-Reply-To: <20240613095014.357981-4-alan.maguire@oracle.com>
References: <20240613095014.357981-1-alan.maguire@oracle.com>
	 <20240613095014.357981-4-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-13 at 10:50 +0100, Alan Maguire wrote:
> Map distilled base BTF type ids referenced in split BTF and their
> references to the base BTF passed in, and if the mapping succeeds,
> reparent the split BTF to the base BTF.
>=20
> Relocation is done by first verifying that distilled base BTF
> only consists of named INT, FLOAT, ENUM, FWD, STRUCT and
> UNION kinds; then we sort these to speed lookups.  Once sorted,
> the base BTF is iterated, and for each relevant kind we check
> for an equivalent in distilled base BTF.  When found, the
> mapping from distilled -> base BTF id and string offset is recorded.
> In establishing mappings, we need to ensure we check STRUCT/UNION
> size when the STRUCT/UNION is embedded in a split BTF STRUCT/UNION,
> and when duplicate names exist for the same STRUCT/UNION.  Otherwise
> size is ignored in matching STRUCT/UNIONs.
>=20
> Once all mappings are established, we can update type ids
> and string offsets in split BTF and reparent it to the new base.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

