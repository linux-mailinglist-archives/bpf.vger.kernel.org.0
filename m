Return-Path: <bpf+bounces-35300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D78C6939778
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 02:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D64D1F2265B
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 00:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DEA4962A;
	Tue, 23 Jul 2024 00:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yy6xQS0L"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1564147F41
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 00:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721694697; cv=none; b=axaPPuaxrjMsJr9H+pGrntrIHQMS33KZzrZfF1X2b5yobWugGaT3JCiv7NXvb/GQ8hEKEOuZWIBHdvlvhVR58zYjQIECYUnIsHRZlOPjvECo7d4K6TJUnhNdbtcTIpNeUMKuIOOlozqTPHHY+ioKlXocYnwRIhNlKE9PWtKFn24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721694697; c=relaxed/simple;
	bh=3A4FYo80XYTWNgHGPirIkvbNkEyNMwdy2ErV+2UeXaM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:Cc:Date; b=BWly8npwTe6DiUW+qX23GjISROIt+Ps6fl7b/QeYZZBbRQC82iWi36cQgsy8X/qDMnWfbllDxAUGDrjBDD6nlPqoNTAXwtBCdl196D9qrhsnmB6RFCrDahEawKqB3l3juHT/pMSZlOKq1RKck9swtBnBqoO92UyBlP7nvZz3+3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yy6xQS0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4273C4AF0D;
	Tue, 23 Jul 2024 00:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721694697;
	bh=3A4FYo80XYTWNgHGPirIkvbNkEyNMwdy2ErV+2UeXaM=;
	h=In-Reply-To:References:Subject:From:Cc:Date:From;
	b=Yy6xQS0LNsU86ZWPD1mFLGb23fw0DfUejAkE8GbHIfg9KKEa+gE2dOGXQAu1JDvvf
	 9fzjLwuJzy+/9/d8S4EcJDGmzbf0FgIr8J2QagYQ/pIMsG73NXu9P2rcoBwk700Tba
	 vvDYLeRvRQ+7DI4pbZlqJsQmaWyhmYUK6gfVKLrMXRMSZ4Ik7IrL6pcMdP8fbsh7NZ
	 4DvkJZC78WP+LLrbZTd/5baIGwTdroGgV78BPEqEFdjxdt4szjJPY/zsyrT8E2MGEk
	 RJWEKHbfVrueMmnljqUrLGMGlEWbL5G5oXBIbY9SWU1ZRNFMiugOndBvIDWfSofwae
	 0K5C5gA2oQZ0w==
Content-Type: multipart/mixed; boundary="===============7728707581890442266=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <29b911633459d7b735480d545fdbf0e1e094947451bb463982467d5d047af41b@mail.kernel.org>
In-Reply-To: <CAPPBnEYO4R+m+SpVc2gNj_x31R6fo1uJvj2bK2YS1P09GWT6kQ@mail.gmail.com>
References: <CAPPBnEYO4R+m+SpVc2gNj_x31R6fo1uJvj2bK2YS1P09GWT6kQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf/bpf_lru_list: make bpf_percpu_lru_pop_free safe in NMI
From: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Tue, 23 Jul 2024 00:31:36 +0000 (UTC)

--===============7728707581890442266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [bpf-next] bpf/bpf_lru_list: make bpf_percpu_lru_pop_free safe in NMI
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872106&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/9984219168

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============7728707581890442266==--

