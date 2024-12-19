Return-Path: <bpf+bounces-47373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C88869F8819
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 23:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D80718986FA
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 22:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1A41F1913;
	Thu, 19 Dec 2024 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="mUcMiJsB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1851EE7C6
	for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 22:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734648675; cv=none; b=DbxEqQfgo+lpIV1qsRRtoAmbY9RXYc9d69Y4U7YhaJuOiHV/VskVA+Ad6zxGZkJ/mCW4cXsrTuPDlOWC1snSrIP0EKxlUdaYGHDp4aAhSa6d3OpICvVYQow1VZV7JS6tyKr6JhG0PnqSClSU6Jg+CIVO7/bKFNrb09Ha/AjxrLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734648675; c=relaxed/simple;
	bh=DZo1jpv43AeHt4bHpd/kDFTFa+DfkIQceBcD9hkI9bc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yyz62ZijiBrEil0oUtJWfTbk61nNUk3wTBpN+a9ND/besvLnGuPBW8+PIqjrMtJuE3W7rN+RQRyCr5o2DJEMG9RkqYyGc9BYprS7MnnPefLsxAHOi6mehWlZbByRn09jlVQ3HU5fxNhbS4pTvP3zZBtRfQGnZwEDpQaTEnI0U6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=mUcMiJsB; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1734648665; x=1734907865;
	bh=DZo1jpv43AeHt4bHpd/kDFTFa+DfkIQceBcD9hkI9bc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=mUcMiJsBF44jkbHOgVpzOZgQmqVTJMyDQ8+G4Ua5bEDEKLXX85hCQZziTd+jEJDRT
	 RZQawJtaTNbCkPDDGQ81ZV4cuUdeAbndUNMsFmLP39jxqcfrd/onmKy3DRTYpdaDoc
	 LMXFzDvmNtcohXggIM669xEkYnfTryTiXW9KJBaLeaWOh4HxdO17fFYiKelircyjMX
	 KcUHAybKAmjkKtwuGtWqKzaFgLcfif7f1+Qf7biXueY5GFWcYcQNIM6cA0CTWzIOl8
	 ucLDtJadJeEECdL3TzD2SKvaZtftFmM3frWXKwRk0czCLuNpBH4L0Wft3fENapl9A9
	 URfO1TJGcsI0A==
Date: Thu, 19 Dec 2024 22:51:01 +0000
To: Tejun Heo <tj@kernel.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: David Vernet <void@manifault.com>, sched-ext@meta.com, kernel-team@meta.com, linux-kernel@vger.kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH sched_ext/for-6.13-fixes] sched_ext: Fix invalid irq restore in scx_ops_bypass()
Message-ID: <ouIylyHgXTVZ9RiyVeHZ26YXQLKMEKHoOVPWIgpWRDD2FL2RDwwUEocaj4LMpMR3PjbwpPuxEnJAjMeD4e7LnWIAYvIbGC5BPvPGtzyumYk=@pm.me>
In-Reply-To: <Z2MV001RfiG7DNqj@slm.duckdns.org>
References: <20241209152924.4508-1-void@manifault.com> <qC39k3UsonrBYD_SmuxHnZIQLsuuccoCrkiqb_BT7DvH945A1_LZwE4g-5Pu9FcCtqZt4lY1HhIPi0homRuNWxkgo1rgP3bkxa0donw8kV4=@pm.me> <Z1n9v7Z6iNJ-wKmq@slm.duckdns.org> <SJEarr1ol1z7N83mqHJjBmpXcXgHNnnuORHfziWINcHBQCJzY0RczexPKxdq_vE5cDYPeO3bx1RdsNhLqw5UYI40HSX9cPZ9rdmebYwwAP8=@pm.me> <HdoCQccNk3GZdnPx5w1vuAfOMMgtWeUgrUhn_e8B-hyRrWoOPakTGcoI3Q4-QmK_44msuvivoRUykxxeB82uR-S3enkmFaQl2t6Zgu-Nq6Y=@pm.me> <Z2MV001RfiG7DNqj@slm.duckdns.org>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 7c3519267b14410bd28f11c413ad7d18e518bf30
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, December 18th, 2024 at 10:34 AM, Tejun Heo <tj@kernel.org> wr=
ote:

>=20
>=20
> Hello,
>=20
> On Tue, Dec 17, 2024 at 11:44:08PM +0000, Ihor Solodrai wrote:
>=20
> > I re-enabled selftests/sched_ext on BPF CI today. The kernel on CI
> > includes this patch. Sometimes there is a failure on attempt to attach
> > a dsp_local_on scheduler.
> >=20
> > Examples of failed jobs:
> >=20
> > * https://github.com/kernel-patches/bpf/actions/runs/12379720791/job/34=
555104994
> > * https://github.com/kernel-patches/bpf/actions/runs/12382862660/job/34=
564648924
> > * https://github.com/kernel-patches/bpf/actions/runs/12381361846/job/34=
560047798
> >=20
> > Here is a piece of log that is present in failed run, but not in
> > a successful run:
> >=20
> > 2024-12-17T19:30:12.9010943Z [ 5.285022] sched_ext: BPF scheduler "dsp_=
local_on" enabled
> > 2024-12-17T19:30:13.9022892Z ERR: dsp_local_on.c:37
> > 2024-12-17T19:30:13.9025841Z Expected skel->data->uei.kind =3D=3D EXIT_=
KIND(SCX_EXIT_ERROR) (0 =3D=3D 1024)
> > 2024-12-17T19:30:13.9256108Z ERR: exit.c:30
> > 2024-12-17T19:30:13.9256641Z Failed to attach scheduler
> > 2024-12-17T19:30:13.9611443Z [ 6.345087] smpboot: CPU 1 is now offline
> >=20
> > Could you please investigate?
>=20
>=20
> The test prog is wrong in assuming all possible CPUs to be consecutive an=
d
> online but I'm not sure whether that's what's making the test flaky. Do y=
ou
> have dmesg from a failed run?

Tejun, can you elaborate on what you're looking for in the logs?
My understanding is that QEMU prints some of the dmesg messages.
QEMU output is available in raw logs.

Here is a link (you have to login to github to open):

https://productionresultssa1.blob.core.windows.net/actions-results/99cd995e=
-679f-4180-872b-d31e1f564837/workflow-job-run-7216a7c9-5129-5959-a45a-28d6f=
9b737e2/logs/job/job-logs.txt?rsct=3Dtext%2Fplain&se=3D2024-12-19T22%3A57%3=
A01Z&sig=3Dz%2B%2FUtIIhli4VG%2FCCVxawBnubNwfIIsl9Q2FlTVvM8q0%3D&ske=3D2024-=
12-20T07%3A00%3A35Z&skoid=3Dca7593d4-ee42-46cd-af88-8b886a2f84eb&sks=3Db&sk=
t=3D2024-12-19T19%3A00%3A35Z&sktid=3D398a6654-997b-47e9-b12b-9515b896b4de&s=
kv=3D2024-11-04&sp=3Dr&spr=3Dhttps&sr=3Db&st=3D2024-12-19T22%3A46%3A56Z&sv=
=3D2024-11-04

Generally, you can access raw logs by going to the job, and=20
clicking the gear on the topright -> "View raw logs".

>=20
> Thanks.
>=20
> --
> tejun

