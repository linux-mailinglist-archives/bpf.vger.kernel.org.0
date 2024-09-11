Return-Path: <bpf+bounces-39618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 767B997561A
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 16:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93A31C267C5
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 14:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749391A2C0C;
	Wed, 11 Sep 2024 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3R9T62L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C202115C13F
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066474; cv=none; b=A9kwBT3UEloDFx+SWdyoPJb1KbLHlnrwDxMt7EthdhkddXvf/a5IUbOlYaIwFB6YOCetPetAZA3o3dsoaJRmyPrJ9ae82ai0rwH2Lz4gClTf+DrPyzE/9QDPyDu1+3vkl5+KeOxAILzH8I5pwKwfG7D0bKepdNy7GHCWbZ1UjZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066474; c=relaxed/simple;
	bh=1cJtQoJtpI0ilZVSejOK4bxruWxBsYod1aKaB8hmPH0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EiJNimzMCXk4xw+9eWfiXGAfTx9CCHeJedU1WGfSnDRA2JuiIfKrlx83JioFLSvb2ywoysCf76Mjvo/A+GHdiLVVCny6wY9NJ40qcATXBFYFIrtojlATMS+PijOeUBdJgqkYqONns//91+RaLWZcS6Nml7IK0VMKGGrdhbzHxWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3R9T62L; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71798661a52so797537b3a.0
        for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 07:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726066470; x=1726671270; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cJtQoJtpI0ilZVSejOK4bxruWxBsYod1aKaB8hmPH0=;
        b=m3R9T62L0syMjHMYs8xC2SuElKRMuvJUTi3XFsdD8ZOZJugFELgjABuxFZreJltm6e
         JpV76LDHi6Sx0StK7IKcumqKFeJm8MAg73OYVB33dFov42btvKTB31mthN8hKPpxPu+E
         bKPp8sy+iEHvnoaIDwwtCmlbmcMinOwMaRJFQ4JhetvSexN7n05/mlfol3AqosD5dqO6
         jYWFQGKxP5B2YGK4u37WP9PYquGIinDpUeeDUhiKZuzMYq7/S8D6w9kEZCwIWjY8BTPy
         eu4J8+bZT3gXgWuyEZHhoGODHSPOj3dz9lhflO7z99OJLDi2gAL3Pd16dR9MWu0BY0dp
         EHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726066470; x=1726671270;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1cJtQoJtpI0ilZVSejOK4bxruWxBsYod1aKaB8hmPH0=;
        b=nQ08AfEn70kHDi/V498Ex5KNGFRYVdqObDElqs934iFcY5EMAfy8PZb7abMrag+wBa
         b2IXDPwYy/q1Lpn6hdwNphbX8MBUEHXFN3hbIgqqbOFpgPKq+HX61my4hbmqPxy646xE
         3Rr8tkroaxHGVxArB8xl919iRnaQNeKnew+iXxCYQMlV1xAmhgT7SQ7tUX0/yHQQweIM
         eTB7IZi0dQ5/GWnm05NcgkZigO4TosFydOAqR5L+xa01xAFAjGFrTWwjiVqJvJ3eOHHb
         stZNkYwkOZGgnA8xr7k4HarO1TiP/GXKw9ddqj+G96dTioNuqF8nlUfdt/zRxg6Ekm8d
         +HlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9eK7wt1+DHejGdXxazE5aGJFOeIyG3KDIzNDG1B25biE/SCfK2NNtPn36cnLOtVkbnEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5UOtIPh6Go5QXF07hIVFwa062kH+jNuPSUK2OdxzT3crCnNVN
	EA9Y+YZ4S1glQgmHQ3COUDxV5b4jmLu9YpLnHOLa/DA3l3xSXgE1
X-Google-Smtp-Source: AGHT+IEXXTOoTFB5mpDDSnVR1+lv3cR1Nm2BA2yE8XUCPunbtIfjQmMbotzQVYZfoOqx1DsaqDM2+A==
X-Received: by 2002:a05:6a00:66e4:b0:707:fa61:1c6a with SMTP id d2e1a72fcca58-71907f0f6ddmr9961129b3a.10.1726066469724;
        Wed, 11 Sep 2024 07:54:29 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7190f888a78sm2810936b3a.140.2024.09.11.07.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:54:29 -0700 (PDT)
Message-ID: <67451140439fafa1bae3e3b010d2c6b9969696a1.camel@gmail.com>
Subject: Re: [PATCH] Fix a bug in ebpf verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: lonial con <kongln9170@gmail.com>, bpf@vger.kernel.org
Date: Wed, 11 Sep 2024 07:54:24 -0700
In-Reply-To: <1726037521-18232-1-git-send-email-kongln9170@gmail.com>
References: <1726037521-18232-1-git-send-email-kongln9170@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-11 at 14:52 +0800, lonial con wrote:
> In find_equal_scalars(), it should not copy the reg->subreg_def, otherwis=
e a bug will occur when the program flag has BPF_F_TEST_RND_HI32.
>=20
> Reported-by: Lonial Con <kongln9170@gmail.com>
> Signed-off-by: Lonial Con <kongln9170@gmail.com>
> ---

Hello,

could you please write a selftest for this fix?
(please let me know if you need some intro on BPF selftests).

[...]


