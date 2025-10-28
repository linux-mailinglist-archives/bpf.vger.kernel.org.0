Return-Path: <bpf+bounces-72577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D85C15BED
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 17:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 13860351008
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 16:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00EA345738;
	Tue, 28 Oct 2025 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="O/mEk1IJ"
X-Original-To: bpf@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE632D5957
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668187; cv=none; b=ECryIEier8uNh6/665FOKFnnOEYb53sGZnnEpEjWSnzBIQzXIi9LleXRjZknsIJRNtUTzoJpaHXKLa1Bvq9er6RL1naHQAPwdoxPJuMFxvjqVF1lWbA1f8/cBswISE5My0daOTWScX31cetYVMheejatznAkN9Y30ybUoqw9utg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668187; c=relaxed/simple;
	bh=aDZFA/XJVv1lEwaX7z09NSQIhGALV+zbSDqdbk5QFJI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HLBqRjeOX9Ljb1NAi6awxE5r1Q7hnST3jqpCGloZk8lduXbL6VySzYUM4O4I4p0sSfQYoDyQyfhoMjAJGfobiHDu6CdDUE2V1o2HBbyaBLNTu/49daAz24nQCli62iUEQsknlpb0IkGoGiAJQfXeuKFfDAI6OS+Lw1zmOvLZsgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=O/mEk1IJ; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1761668185;
	bh=aDZFA/XJVv1lEwaX7z09NSQIhGALV+zbSDqdbk5QFJI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=O/mEk1IJ1XAUbBYuPuTsGUpM53h3iPAUhmLmFIHXTIkfEK0fVZFrH1WsOd9yyAR1N
	 f6iQaUM0NaEPhFaycp7L1LS7L8D6eEDTeLBU1WPaKLkyVEfgA5FHVB8qMf+11dHGUP
	 2O5HOl9prSVx6GnBsk3h3fYXsVVzvt+lY65f5fJw=
Received: by gentwo.org (Postfix, from userid 1003)
	id 5A3F1402C4; Tue, 28 Oct 2025 09:16:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 59593402BD;
	Tue, 28 Oct 2025 09:16:25 -0700 (PDT)
Date: Tue, 28 Oct 2025 09:16:25 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
cc: bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com, 
    will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org, 
    mark.rutland@arm.com, harisokn@amazon.com, ast@kernel.org, 
    rafael@kernel.org, daniel.lezcano@linaro.org, memxor@gmail.com, 
    zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com, 
    joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, 
    konrad.wilk@oracle.com
Subject: Re: [RESEND PATCH v7 7/7] cpuidle/poll_state: Poll via
 smp_cond_load_relaxed_timeout()
In-Reply-To: <20251028053136.692462-8-ankur.a.arora@oracle.com>
Message-ID: <ac007fbf-8c8c-662b-ef7f-be0266f7ceeb@gentwo.org>
References: <20251028053136.692462-1-ankur.a.arora@oracle.com> <20251028053136.692462-8-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>


