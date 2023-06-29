Return-Path: <bpf+bounces-3681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCA1741E91
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 05:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A6E280D1B
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 03:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5915E1C20;
	Thu, 29 Jun 2023 03:07:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECF41365;
	Thu, 29 Jun 2023 03:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E96C433C0;
	Thu, 29 Jun 2023 03:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688008021;
	bh=0wUmrTKi+F9zULlSo7/71FmT1s0tZ0GbGVGIuX4zY68=;
	h=Date:From:To:Cc:Subject:From;
	b=neRolT3bQeY6i7ED/G0YD3d6F5rzxleE7xk/338gJAULnJJkCCv6hO43yEpXAdrmI
	 dHRGv7+EYQIH16yU+Yo9saNGRt/75cLuF7qRGQaJq3mi+3NtniHElvuQc8PHWXvKpZ
	 dSi8G8Zlcqrbh+FMHw/FoCYh3kbvDO9KAEkiFgnNw2ty9rmIPVfu8hNTBlPN7AuK1F
	 rtE5NzpubfsUl8gkDavlPXin2GDEfB1cWsQEPqgqiqj6vhkNPkEpWHp/akPZ/8nsNc
	 4vZrxW8aXVx9vOsDrdDzmnq69pNC/6N+2UTZv/isdtI/y4DhTXd8pIS98Bj/CXCrCU
	 4O4lxGNBSC9TA==
Date: Wed, 28 Jun 2023 20:06:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org
Subject: clang/llvm build broken
Message-ID: <20230628200659.4a265b99@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi folks,

we forwarded the tress but it looks like the clang build of Linus's
tree is broken right now (at least with clang 16 and 17).

Song reports that the fix is pending. We'll try to send a new PR
and forward again as soon as that's resolved. For now we'll need
to ignore the failures.

