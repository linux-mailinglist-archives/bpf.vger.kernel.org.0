Return-Path: <bpf+bounces-60457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C90D6AD6F32
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 13:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8351898CE3
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 11:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236E223C8C5;
	Thu, 12 Jun 2025 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfKNkqMJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9120AEC2;
	Thu, 12 Jun 2025 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728271; cv=none; b=hpnjNZtSL+dD+NklP9VWjGpAM57H8odvCMHAigv1FwtGJNhwMry3LdwzL7mz/+V9ohQkV3qjN6VWF1uM+B9j0B+ZIfdWrrM4A0r27lRFrPdrIjZUPG1bH3sB0Ego85Vs5fQ51C7qDJ3Aq/OkKYV3gJu4TQguOdmIm23n1tvoIH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728271; c=relaxed/simple;
	bh=RC6e67q4bD7RzUdBsPC19A7/O1+Ylly3nWUTzq8H6C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usGvXV6dmIgCuiYWR78MlC1fV5ADpotvMBAq788jkm6nqOhPoCewFMU/8D5V6vifaz05xJOTulXBnLddjnDCL4v4Bhzr07fZk9a7Pja/h2pWkKetmdQ6MdZfQhCmEBiKmyVzrmu6OwXQMqHXTv8QxQXaHquaiWds7ZK/LfDLrH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfKNkqMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDB6C4CEEA;
	Thu, 12 Jun 2025 11:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749728271;
	bh=RC6e67q4bD7RzUdBsPC19A7/O1+Ylly3nWUTzq8H6C0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LfKNkqMJ230N0EmQJ6n6F5hxs2eDHc2gDzUqnaFqxjR2BzP+se/A2VupzCMhrI4gb
	 9NYBUQi6O74YbTU15kOTP7LtYwDO6nlpekDG4/rRf81shqTxXz5puLtCfFMvrC1Ez8
	 lC0MdZSRw4aOzUbAy3MWk4X+otN1Bl7AvHQP+2SamIX9i1DphEmtbMo4CBHyTrmcS0
	 MUdzc/iYg1tYTc5iGlJ+oeZUq/maoaBSzH0FDgLo2Lkc4GZua4eYLruLegRywdBiqV
	 mpLSscXiDGCpK6qASc0UCBqdRsHIBwtAVRWHdD2/UFkcmRUXp26vKsR4TOHPK4TG94
	 WUZI4sxPL5xPQ==
Date: Thu, 12 Jun 2025 13:37:48 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
	bpf@vger.kernel.org, xiqi2@huawei.com
Subject: Re: [PATCH 2/2] rcu: Fix lockup when RCU reader used while IRQ
 exiting
Message-ID: <aEq8DAHY0ycCOmoN@localhost.localdomain>
References: <20250609180125.2988129-1-joelagnelf@nvidia.com>
 <20250609180125.2988129-2-joelagnelf@nvidia.com>
 <aEgjvGkYB0RoQFvg@localhost.localdomain>
 <5568ff6b-6d5c-ea63-3c4a-c0714103aa9d@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5568ff6b-6d5c-ea63-3c4a-c0714103aa9d@huawei.com>

Le Thu, Jun 12, 2025 at 11:06:07AM +0800, Xiongfeng Wang a écrit :
> +cc (Qi, my colleague who helps testing the modification)
> 
> On 2025/6/10 20:23, Frederic Weisbecker wrote:
> > Le Mon, Jun 09, 2025 at 02:01:24PM -0400, Joel Fernandes a écrit :
> >> During rcu_read_unlock_special(), if this happens during irq_exit(), we
> 
> ...skipped...
> 
> We have tested the below modification without the modification written by Joel
> using the previous syzkaller benchmark. The kernel still panic.
> The dmesg log is attached.

Yes, it's a cleanup that doesn't include Joel's change yet. So this is
expected.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

