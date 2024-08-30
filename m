Return-Path: <bpf+bounces-38495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA36A9653C0
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 02:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB241C2136F
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 00:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C4A380;
	Fri, 30 Aug 2024 00:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUHCSUOJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBFA182;
	Fri, 30 Aug 2024 00:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724976328; cv=none; b=mIhn2K7IRV+sKN2AxYnSS09JrS6vTGgNWqTN/oQnPxjAL4fcWE/e/846IxsOOvDw5rI7GyyQ10V9YHvC1cueVAuFyWxUJ1mJ8vCR1kxrtsMN+fwodJk9JMd9M0vVbi0BHWHjpBA+qEVdL/AqFnAfHqkvGuMspPkEBo/wAV8bRJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724976328; c=relaxed/simple;
	bh=sSlFIgz3u9weFyLbXNi6UH3Br+zjOBsoBVkY5w1r8fA=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=i10iEB+W8DAEMznIaDwD7h8IEaoGoPCGKWXdR5BNZuJ8Ynp1jLJKUq7TFLn1sV+DsQczYJvE7Atyd1LI3P27281+VoYh772wZbIqbKPwWjw7/lrX7wG80ycCHRqMXOK3ARBgKFc20kgNLt3ojtM4aR8PzpN4DdH9bWzxt23ywes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUHCSUOJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-201ed196debso10680675ad.1;
        Thu, 29 Aug 2024 17:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724976326; x=1725581126; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sSlFIgz3u9weFyLbXNi6UH3Br+zjOBsoBVkY5w1r8fA=;
        b=IUHCSUOJhDZorTK0Ly3ZYWWZBdDCsFnVBnkK/SWwleEI0wiUUgcRuNc6nlfyUmC9KM
         synKEhkiXf9VmPjKkyhSbfnut6v1b3MtN5voMwbuN0/fGzYvaMoroiYE84byvWMOtTDP
         JotfBCQPAJ6B1un7Qt4XIih+rpBQ/mwlNoDWNkgzjc+5brVLw9spRt+og7jMgzbKn9S6
         aPp5esGe7ohoJ8q4hrCNPencwdusms9yLpEC0DF8QChYSz33uYCNFGHE5S6oPFRex5Lx
         ipzxNqF+KLSHB2TIy276KNLGI3fcDin5eqtUR9LmIrVWyaNsd5qJ14IVYI2O3brTO8Wk
         m67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724976326; x=1725581126;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSlFIgz3u9weFyLbXNi6UH3Br+zjOBsoBVkY5w1r8fA=;
        b=VNhAX9tjVTtOmVWtnCbONgPZ/tLoI8L43iZmPjfJgjqN/QgpsXkGEz2/+pNV+NYWeB
         lJ0BfDgGDyg8eJfog2P4vsnLeXIz6cTYVI0uTEHDMcc5HMgK76i3Y3/8Zg0NHAciuV5n
         KpKIXVfXy+MqPICt0oeP6L77nkVihvYJVd/pfNFJo8DXwlteRFzeARuiRG4xCyz/enGO
         JIFarKfInDgpMX4sxUo+tLBxsvjYEsyswdBgNGfgMTVt830QlywODvhLPRKqQlpFHhHi
         IvKqL7slIIpx3vZd1K5RzdOIxoPbInzs7zlm9oEspdS9VUdBTBnQsRi0/6Xn3zXqPscJ
         Et5A==
X-Forwarded-Encrypted: i=1; AJvYcCU6FNmDKRRbcFOvl3FAcdwm3xOgLv7RB/ibXajKq4NcyTT5332RU1GGRhT8o8idIHCi1I8=@vger.kernel.org, AJvYcCX6FGYPiX9VeLWqG46aprSf7yedgQ9P/46RdkQpRvKKYU4JS2UDqZ4I9jNZInC02FGpW4r8OAUBVg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr1Yu7fHyaQU9hFO9/JbtEjjl5K6l3VEvXGsFzPen8mdN2bH3X
	gm76I7tp7QCGgmKHvdsOD3wENcLOsf+bC2mS4Q8z//Fo6QROfU8C
X-Google-Smtp-Source: AGHT+IHZHmQ3ZHcF5iIo3Ezo0kM+zarHZ8k5wlyvsVcKqsB+F69XkfM+9B/cufoePpbce1hmkkZqlw==
X-Received: by 2002:a17:902:ea07:b0:202:4b99:fd34 with SMTP id d9443c01a7336-2050c380dc6mr46653245ad.14.1724976325882;
        Thu, 29 Aug 2024 17:05:25 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b3196sm16758535ad.38.2024.08.29.17.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 17:05:25 -0700 (PDT)
Message-ID: <6358db36c5f68b07873a0a5be2d062b1af5ea5f8.camel@gmail.com>
Subject: FYI: CI regression on big-endian arch (s390) after recent pahole
 changes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: alan.maguire@oracle.com, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	andrii@kernel.org, martin.lau@linux.dev, songliubraving@meta.com
Date: Thu, 29 Aug 2024 17:05:20 -0700
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Arnaldo, Alan,

After recent pahole changes [1] BPF CI fails for s390 [2].
Song Liu identified that there is a mismatch between endianness of BTF
in .BTF and .BTF.base sections.

I think that the correct fix should be on libbpf side,
where btf__distill_base() should inherit endianness from source BTF.
If there are any plans for new pahole release,
could you please postpone it until current issue is resolved?
(I should have a fix for this thing by tomorrow).

Best regards,
Eduard

[1] c7b1f6a29ba1 ("btf_encoder: Add "distilled_base" BTF feature to split B=
TF generation")
[2] https://github.com/kernel-patches/bpf/actions/runs/10622763027/job/2944=
7973415


