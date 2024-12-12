Return-Path: <bpf+bounces-46727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409E29EFABA
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 19:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D1B172680
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 18:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948832288D2;
	Thu, 12 Dec 2024 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="hVYs6qzJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51877223C69;
	Thu, 12 Dec 2024 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734027189; cv=none; b=JgiXJiN3c8fMpLAGcCXwzlf6R1JibaVo9tcL6K3b3lVhHHz4FdrFfeOPwoXGGAyYOBGlxL2p1TvWTV8+NdjUXbxhk3z9qSI9HdmgxfRXzHCVNTXd4WedzzbtMvPGPWoc5TsmqJ69zR6SQrHpF0mQ7V8WVGrgblVN7BpH+ODtrGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734027189; c=relaxed/simple;
	bh=klN8TCjAFsZYl5VMZCaq9NYaAK6GGI+tkrvt8Xgklug=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OzBs0yfGjBh0iT4rZ13PHmFv7/7PlDFw1iOkcU+eXO27+JnKz1HqCR+TMh3sMFps7IWKJYFPl+1ratOFsRFcf9/8XAqT0DSRi01m7i7MaDsV5fpTADg1FfAs8sC8sxCpd74KQeWLm8FI2OxlzohIWXTW9hH28ALYzZ8n/mLsI1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=hVYs6qzJ; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1734027180; x=1734286380;
	bh=klN8TCjAFsZYl5VMZCaq9NYaAK6GGI+tkrvt8Xgklug=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=hVYs6qzJEJA34TDi5u2nX3e48/hJeb11/9ZfLDVytOk2XNKnViz09yPDxfDqfg9Km
	 f0XmYUF1+pZpMJqhYFcL4RlHQCBCMlUEATp6cIkyv93qiQGqwqtzWXVBKl9rCTRGFa
	 ioLJs98Bmy3VByFZACSkaK9y3fILWGgEnMwk9g65rlI1bgiX4a4mDtzVSoHb9stozv
	 ZR99mVnWfigIx4M8i/TxnmLImmboguFF/elyvFm91l9otVfqIQnLx5I5MLTeTn7Jcx
	 JhnBpl7iwZ0RqT8+xCFXoHK4Z3buakt3AeTbmfOfNHu4iqIQzQE+4mTIPdSG3wJr5z
	 jPclEq+UGfjMA==
Date: Thu, 12 Dec 2024 18:12:54 +0000
To: Tejun Heo <tj@kernel.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: David Vernet <void@manifault.com>, sched-ext@meta.com, kernel-team@meta.com, linux-kernel@vger.kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH sched_ext/for-6.13-fixes] sched_ext: Fix invalid irq restore in scx_ops_bypass()
Message-ID: <SJEarr1ol1z7N83mqHJjBmpXcXgHNnnuORHfziWINcHBQCJzY0RczexPKxdq_vE5cDYPeO3bx1RdsNhLqw5UYI40HSX9cPZ9rdmebYwwAP8=@pm.me>
In-Reply-To: <Z1n9v7Z6iNJ-wKmq@slm.duckdns.org>
References: <20241209152924.4508-1-void@manifault.com> <qC39k3UsonrBYD_SmuxHnZIQLsuuccoCrkiqb_BT7DvH945A1_LZwE4g-5Pu9FcCtqZt4lY1HhIPi0homRuNWxkgo1rgP3bkxa0donw8kV4=@pm.me> <Z1n9v7Z6iNJ-wKmq@slm.duckdns.org>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: dea07f9fab95189ad454ec3ff2fb1b408d182190
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, December 11th, 2024 at 1:01 PM, Tejun Heo <tj@kernel.org> wro=
te:

>=20
>=20
> While adding outer irqsave/restore locking, 0e7ffff1b811 ("scx: Fix racin=
ess
> in scx_ops_bypass()") forgot to convert an inner rq_unlock_irqrestore() t=
o
> rq_unlock() which could re-enable IRQ prematurely leading to the followin=
g
> warning:
>=20
> raw_local_irq_restore() called with IRQs enabled
> WARNING: CPU: 1 PID: 96 at kernel/locking/irqflag-debug.c:10 warn_bogus_i=
rq_restore+0x30/0x40
> ...
> Sched_ext: create_dsq (enabling)
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : warn_bogus_irq_restore+0x30/0x40
> lr : warn_bogus_irq_restore+0x30/0x40
> ...
> Call trace:
> warn_bogus_irq_restore+0x30/0x40 (P)
> warn_bogus_irq_restore+0x30/0x40 (L)
> scx_ops_bypass+0x224/0x3b8
> scx_ops_enable.isra.0+0x2c8/0xaa8
> bpf_scx_reg+0x18/0x30
> ...
> irq event stamp: 33739
> hardirqs last enabled at (33739): [<ffff8000800b699c>] scx_ops_bypass+0x1=
74/0x3b8
>=20
> hardirqs last disabled at (33738): [<ffff800080d48ad4>] _raw_spin_lock_ir=
qsave+0xb4/0xd8
>=20
>=20
> Drop the stray _irqrestore().
>=20
> Signed-off-by: Tejun Heo tj@kernel.org
>=20
> Reported-by: Ihor Solodrai ihor.solodrai@pm.me
>=20
> Link: http://lkml.kernel.org/r/qC39k3UsonrBYD_SmuxHnZIQLsuuccoCrkiqb_BT7D=
vH945A1_LZwE4g-5Pu9FcCtqZt4lY1HhIPi0homRuNWxkgo1rgP3bkxa0donw8kV4=3D@pm.me
> Fixes: 0e7ffff1b811 ("scx: Fix raciness in scx_ops_bypass()")
> Cc: stable@vger.kernel.org # v6.12
> ---
> kernel/sched/ext.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 7fff1d045477..98519e6d0dcd 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4763,7 +4763,7 @@ static void scx_ops_bypass(bool bypass)
> * sees scx_rq_bypassing() before moving tasks to SCX.
> */
> if (!scx_enabled()) {
> - rq_unlock_irqrestore(rq, &rf);
> + rq_unlock(rq, &rf);
> continue;
> }

Hi Tejun,


I tried this patch on BPF CI: the pipeline ran 3 times
successfully. That's 12 selftests/sched_ext runs in total.

https://github.com/kernel-patches/vmtest/actions/runs/12301284063

Tested-by: Ihor Solodrai ihor.solodrai@pm.me

Thanks for the fix!

