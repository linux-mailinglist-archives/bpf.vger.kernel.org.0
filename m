Return-Path: <bpf+bounces-19098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F2C824C90
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 02:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B572861D4
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 01:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D031FA5;
	Fri,  5 Jan 2024 01:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="axeNh4il"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A698E1FA3
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 01:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28c0df4b42eso91730a91.1
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 17:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1704418296; x=1705023096; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=V2ip3HyFSIgJvnIybn9HMd2m8Il7ZR7wesMKa0O8xLI=;
        b=axeNh4illfp7CqbsL+tDQbLvnAU6PPkQdM2jvfqlAKwDbp21ukWpSQTxiyBMMmajrZ
         HzSyDiGMqNGcy9zDajPnrHr8EryB3AiXCU6JE+vhz2T0CSA965UI4/nn7OUT9qU9z2ro
         t3TryITHYvn6NY7HI7xd6pwN0SCKe7Qp7GiFZKmYsURqyH57EcnxBa2aswCgZ1yo3h8k
         hgtbnKn+nVDXW2sclSR3CHcd4cUhAAHMvVfXylt8030vKr8OkVmUKfi8F/pibmSKzOWl
         gQjBUGC5TjlMWRNNzVHPRUXzME74AbSNDWuI3n2y2svCBHn76SZdlN5X5l2QKB8Yl1Ty
         XX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704418296; x=1705023096;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V2ip3HyFSIgJvnIybn9HMd2m8Il7ZR7wesMKa0O8xLI=;
        b=BcTXkIlXjIE8qzj5IDG1b2j1uoz++lozjFQC+hpEg7GmppOtsG9/VOKkQJcsv96Vjk
         imzJyhvjzyhqXvOVHaW0f8+e3rXNLb0+9VhEmrKYFbftDj2nDoS3Pq8FKOELUrtD+9Nj
         4Mt+uqIFEw70/xGmw6pzvRjnw1aEKx+1oIWgp0jDZem5zMvpzc3YqQEkVqEwnOjU+WCR
         mHB9JFXqheSzmxCnE2G3r/iXiJVqfEWgjgaDmESA+uV+3ONyrChnWtghHse42jM5wM3t
         9zg5yQgFstekaglYbMOLg3A94W0wnEnqONkEFYb8Eth1EkJKqWXtGz332zytN+fhSyfv
         yv6Q==
X-Gm-Message-State: AOJu0Yyz09bZxiHOyBm/Wsp/bxm1d22PArVI+4LnffStjW/aoXZ4uKvc
	FrVASQV4Ozl0fwnsTFvFeW0=
X-Google-Smtp-Source: AGHT+IGm42lGvj7Hd2Dqngvfm8PL1uInOI1xwJUAIoTZm1BPLs08wrOFP5SgaAlTzdeXfgco5N1iIA==
X-Received: by 2002:a17:90b:4a0e:b0:28c:65ee:3c37 with SMTP id kk14-20020a17090b4a0e00b0028c65ee3c37mr1703007pjb.9.1704418295780;
        Thu, 04 Jan 2024 17:31:35 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id r23-20020a17090b051700b0028b6759d8c1sm349996pjz.29.2024.01.04.17.31.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jan 2024 17:31:35 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Aoyang Fang \(SSE, 222010547\)'" <aoyangfang@link.cuhk.edu.cn>,
	<dthaler1968@googlemail.com>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <3A7D0A57-02EF-4ACB-A599-1029CFCA7E74@link.cuhk.edu.cn> <015701da3f41$eaab4d10$c001e730$@gmail.com> <20654405-C500-4A24-B09E-A28B25DF32AC@link.cuhk.edu.cn>
In-Reply-To: <20654405-C500-4A24-B09E-A28B25DF32AC@link.cuhk.edu.cn>
Subject: RE: [PATCH] update the consistency issue in documentation
Date: Thu, 4 Jan 2024 17:31:33 -0800
Message-ID: <076801da3f76$eb0cdaf0$c12690d0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQJcMuQj7ImLqPZXOVe7T7DiaRKhUwLxzd5EAg7D4uSvnoJBMA==

Aoyang Fang (SSE, 222010547) <aoyangfang@link.cuhk.edu.cn> wrote:=20
> If so, the value of arithmetic instructions=E2=80=99 code should be 4 =
bit, rather than
> BPF_ADD: 0x00, BPF_SUB: 0x10, BPF_MUL: 0x20. Otherwise the convention =
of
> arithmetic instruction is not consistent with the convention of jump
> instructions.

Good point, you are right that section 3.1 (Arithmetic instructions) and =
3.3 (Jump instructions)
are not consistent with each other.  Since 'code' is defined in section =
3 as a 4-bit field,
I agree that it would be more consistent to change section 3.1 rather =
than defining
8-bit values for a 4-bit field.

Dave
=20



