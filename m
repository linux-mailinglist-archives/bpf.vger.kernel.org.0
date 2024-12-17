Return-Path: <bpf+bounces-47146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A79D69F5A9D
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 00:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70BCC1890766
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 23:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEA81FA827;
	Tue, 17 Dec 2024 23:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="d/z5gZBP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CC31E489
	for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 23:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734479070; cv=none; b=gwL9r0Z7lrhMq0XRAHR0zNPKDFd3jfVraSPtPxF5bhOlD4fzYMhIznv8FA2WrkX5X32xmAsou+Q7P6UtLiE75LQYNrwGs9zhRLlWRTOoxS+ofkPI8DZ3i1fo0dgRJwiyK3T1fpiJYNdRjpWspFrK+hCHp50PtI0GkI6qPXDwYuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734479070; c=relaxed/simple;
	bh=4uKFZOPAP2cHAdStLTDVUYTTZxIg9MJsw8/EM86G1KQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZ+/R9HE4AIYvrjkrBaYfC5DS2chm4C7tD1oGuk42gM7jrL+n+VLVEXhOd+69Kk44hlVMA7PDaXYPW23mQ0DN43GLtOxLnsubgvmYhx+0OZyE159RnIQYDlAdVckVEKzpnZHKZOdxjSYOG/nMXPk44nup7tfiGDLiJWLWwQNIaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=d/z5gZBP; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1734479065; x=1734738265;
	bh=nLhgNj9NBQVGAiwFpYYE8rSZPM9knU+44ZF9moOxMio=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=d/z5gZBPtv0+f604z8tMPR7pEpimZwNRdoFBZhUVzmgU9fWcF5ZBIugN4jM1UHamc
	 Qu4qSNe8/1aXIf3e1VxxM8aqPGFBZQ19gBIt3V5H9OKufHlZuYlbzAHUQO//iQQNSO
	 btMa2rIaCdyZoRA3FJZz6+Ftxpg+9EjAK2ECa4ZvRjAZpVwd6s+O0sx0gezRvQTkN7
	 MxB8BRw52Mr0QA1XokhlUupql++3eJE8jdaCIsNzXz/C7UNqRcG4wbX/P/+W4680ud
	 LbZkrj0OTCvS+fvQjzmo3sa1OVGvFCvmhuuciJJ0uzUceaNG+J31DEWFTAo8cgjhNB
	 UCq/hj3szsO/w==
Date: Tue, 17 Dec 2024 23:44:08 +0000
To: Tejun Heo <tj@kernel.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: David Vernet <void@manifault.com>, sched-ext@meta.com, kernel-team@meta.com, linux-kernel@vger.kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH sched_ext/for-6.13-fixes] sched_ext: Fix invalid irq restore in scx_ops_bypass()
Message-ID: <HdoCQccNk3GZdnPx5w1vuAfOMMgtWeUgrUhn_e8B-hyRrWoOPakTGcoI3Q4-QmK_44msuvivoRUykxxeB82uR-S3enkmFaQl2t6Zgu-Nq6Y=@pm.me>
In-Reply-To: <SJEarr1ol1z7N83mqHJjBmpXcXgHNnnuORHfziWINcHBQCJzY0RczexPKxdq_vE5cDYPeO3bx1RdsNhLqw5UYI40HSX9cPZ9rdmebYwwAP8=@pm.me>
References: <20241209152924.4508-1-void@manifault.com> <qC39k3UsonrBYD_SmuxHnZIQLsuuccoCrkiqb_BT7DvH945A1_LZwE4g-5Pu9FcCtqZt4lY1HhIPi0homRuNWxkgo1rgP3bkxa0donw8kV4=@pm.me> <Z1n9v7Z6iNJ-wKmq@slm.duckdns.org> <SJEarr1ol1z7N83mqHJjBmpXcXgHNnnuORHfziWINcHBQCJzY0RczexPKxdq_vE5cDYPeO3bx1RdsNhLqw5UYI40HSX9cPZ9rdmebYwwAP8=@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 3158c98564974ac0f29cfa5fb33dd80730c04889
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Tejun,

I re-enabled selftests/sched_ext on BPF CI today. The kernel on CI
includes this patch. Sometimes there is a failure on attempt to attach
a dsp_local_on scheduler.

Examples of failed jobs:

  * https://github.com/kernel-patches/bpf/actions/runs/12379720791/job/3455=
5104994
  * https://github.com/kernel-patches/bpf/actions/runs/12382862660/job/3456=
4648924
  * https://github.com/kernel-patches/bpf/actions/runs/12381361846/job/3456=
0047798

Here is a piece of log that is present in failed run, but not in
a successful run:

2024-12-17T19:30:12.9010943Z [    5.285022] sched_ext: BPF scheduler "dsp_l=
ocal_on" enabled
2024-12-17T19:30:13.9022892Z ERR: dsp_local_on.c:37
2024-12-17T19:30:13.9025841Z Expected skel->data->uei.kind =3D=3D EXIT_KIND=
(SCX_EXIT_ERROR) (0 =3D=3D 1024)
2024-12-17T19:30:13.9256108Z ERR: exit.c:30
2024-12-17T19:30:13.9256641Z Failed to attach scheduler
2024-12-17T19:30:13.9611443Z [    6.345087] smpboot: CPU 1 is now offline

Could you please investigate?

Thanks.


