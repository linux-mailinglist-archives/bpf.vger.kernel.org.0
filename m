Return-Path: <bpf+bounces-54753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DD7A7188C
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 15:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2963AD73C
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 14:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B681EEA38;
	Wed, 26 Mar 2025 14:33:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E4825634;
	Wed, 26 Mar 2025 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742999614; cv=none; b=MC28dRWSeySlj3BfiM3ufbr4sBvW5/yRH1TTNbQd31j/NrvcYmzX3XS8V2usn275nH1Fjsvpy/K9uxqxNuV2IdHQ78P3qRo9haFDp+YKH6nwHSjtaQNiJqzJNfhJsqxcYTOQcZI+X5B7IoVdB0Gn5pvqevoqQkQ61pZiLWYS5W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742999614; c=relaxed/simple;
	bh=MaULBIdNn2vB8Nor2XI3gLXRhcvwPLrW8fdv5CNl2O0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTsEUl63KvJmfCl6mT4+ED2tkGq089O94Lrmbi9PKmRTKc0yF7lxDkok2kG5za+BQuA9unQz58SUt927Vh1J82jY0so/Q4PXbj35yjLUnFBEnxmxa59McMokWAKkg5Os1tmTdUX6x/5KzDAM9/ox+j9AUhn1pYkhRWjq6uKr6P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B764C4CEE2;
	Wed, 26 Mar 2025 14:33:33 +0000 (UTC)
Date: Wed, 26 Mar 2025 10:34:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Quentin Monnet <qmo@kernel.org>
Cc: Tomas Glozar <tglozar@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, John Kacur
 <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, Venkat Rao
 Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH] tools/build: Use SYSTEM_BPFTOOL for system bpftool
Message-ID: <20250326103419.7e833208@gandalf.local.home>
In-Reply-To: <67e8c04d-e021-4f98-8020-5ee030fa24e3@kernel.org>
References: <20250326004018.248357-1-tglozar@redhat.com>
	<67e8c04d-e021-4f98-8020-5ee030fa24e3@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Mar 2025 09:59:12 +0000
Quentin Monnet <qmo@kernel.org> wrote:

> > Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> > Closes: https://lore.kernel.org/linux-kernel/5df6968a-2e5f-468e-b457-fc201535dd4c@linux.ibm.com/
> > Suggested-by: Quentin Monnet <qmo@qmon.net>  
> 
> 
> Let's use <qmo@kernel.org> if possible, please.

Updated.

> 
> 
> > Fixes: 8a635c3856dd ("tools/build: Add bpftool-skeletons feature test")
> > Signed-off-by: Tomas Glozar <tglozar@redhat.com>  
> 
> Looks good, thanks a lot!
> 
> Acked-by: Quentin Monnet <qmo@kernel.org>

I added this to my queue.

Thanks everyone.

-- Steve

