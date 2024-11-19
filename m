Return-Path: <bpf+bounces-45141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0A09D1F81
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 06:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A33E1F227F5
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 05:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4B414A4EB;
	Tue, 19 Nov 2024 05:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdLVWdF0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54ED1876
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 05:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731993259; cv=none; b=qO6LZ0aHwqZsphCNOvE/lJvTQ3XYDujtGPghItO/23lojOCEkYQtJn8e5GzZ0e983VEWm5hwyl5eJnF0hD8O45QpSNbY/amkejmGZgf2S2z9dGzLmNB8SvAKE6/ZxRZXyYHhyGLus/dBEXKBSa9h4J55XexsRtoJabyeLjoSHNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731993259; c=relaxed/simple;
	bh=lq+fj6io/LY2Nc2FcGhOWfUckp/dyWpa6+CTulrekdM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WKY38RfSL5jrL4tVL0ZbiItHnQ5xN2LiA/srdTuQlVb96ajV0PNwOi6BTEFzdiXsjNME9msrf5tZyYXpIIhyjPitLwBJiLaJOG64Elx3/lUKW9U8tvqe2Fm93GaekamxXzAru8QaRr0xkLUe+RtPTxUVTS/uETjN+JsQztxDrvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdLVWdF0; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e3873c7c9b4so536546276.3
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 21:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731993256; x=1732598056; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lq+fj6io/LY2Nc2FcGhOWfUckp/dyWpa6+CTulrekdM=;
        b=mdLVWdF0yz8dtKDEhLS6ZGrMmPmPYa6jJjc2tWMQh/I3YhDQkjE02HRxHU3OhA+xxK
         ngWS9Rdt3vL/sG434OqgDz6ekHRnIbTfQyDLNWLFAMRwdzxa2EYKP3oGul/No8w4hnel
         gFC4UBQ0UlwGDZy6OIty6e7Dj5iKJCt9JmAuFMvSDz3prtK8MZ9TfNkJBkFoKXD2Xelk
         gKKekkF/XFCcVch00eV6YaPYJBfr/AFFYknviH2Odb1zBzBwZS6jZ92m065K7gt2sdLZ
         pzpw4JNE6Ydyyy1/9NXyTG4WoYIUijODsceE9T3QA7eIe0odJ/rc1ps2nuvE5RID9atD
         eUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731993256; x=1732598056;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lq+fj6io/LY2Nc2FcGhOWfUckp/dyWpa6+CTulrekdM=;
        b=PzF/zETuhb4nRUaTYHOCA1iluiE6IQ5wsKi8P38Gs9q7Fai31lmDS/kCxgDvKzaG8j
         SjbCO5c1JlnvmsxRMZ4/TjdR2z9NbE4qQbHZc84MnhOV/q5oLJBtuocyH8s1BJH07g6Q
         bfNiMImGZmKooQp/3K1pl4XivFUl0E2ZkiZBsfbEFl2CGKcfdS+dUJSltLnFkIgM4MLW
         Bd9kZI27ja+qbFc+mkCmSRHm/usmKIQS8pHJNpozGtURrPgJGh5suFPaixYJFMfvr2c1
         FnEO4GOKi7kzh0ei1BF96opbrySlpEilAj3DQVw47XuXGBCjWsIYfFok02U1PtxjM+1c
         ZPEw==
X-Gm-Message-State: AOJu0YwH1FTkjQZ5gad39lOZw4D7XtP279YXMeJkbLe5VjP5yo6RigFb
	0T4TdyUpwY8Fht5J7Q7E18naEXZwOt1bBh+9LMKaCMIyvtUNDRLIwFcrZ1f80iFrwPMBuHUZkxl
	BAUKvH/hzEUuMnk0nr6JHZShoe3rpJm1K
X-Google-Smtp-Source: AGHT+IFQJ08SDPUBHi4tuLtzIKxWUdeZubf3eI6yFzWb3Y2V5doMTKxb2lpMQmD4ecGe6suXmfp2HUB+tcngF8THPhg=
X-Received: by 2002:a05:6902:2b86:b0:e30:84ef:351d with SMTP id
 3f1490d57ef6-e3826129d98mr12712368276.16.1731993256470; Mon, 18 Nov 2024
 21:14:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Keren Kotler <kerenkotlerk@gmail.com>
Date: Tue, 19 Nov 2024 07:14:05 +0200
Message-ID: <CAJKOENWotzg5VswWbkCrbP=QgdPAJhXWOvWBGKpvRA+8WUMMhw@mail.gmail.com>
Subject: bpftool CPU profiling support
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I saw bpftool profile supports cycles metric via
PERF_COUNT_HW_CPU_CYCLES event, which is not supported on some
platforms*. I wondered why there is no support to measure CPU load of
a (ebpf) program via PERF_COUNT_SW_CPU_CLOCK event - I patched the
bpftool to support it (as a POC just replaced the attr event def in
the metric list) and it seems to be working.

So my questions:
1. Is it risky to use it? (Why wasn=E2=80=99t it supported in the first pla=
ce?)
2. Does it make sense to finish the patch and send in order to release it?

Thanks,
Keren


*specifically I tried to run it on Intel(R) Xeon(R) CPU E5-2628 v4 @
2.30GHz (Ubuntu 24, kernel 6.8.0-48-generic) using AWS EC2 machine
(and previously on an Azure machine). I suspect it might not be widely
supported on cloud providers hardwares, but didn=E2=80=99t research this
theory.

