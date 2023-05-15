Return-Path: <bpf+bounces-502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE78D70267A
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 09:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E98A281123
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 07:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD20848C;
	Mon, 15 May 2023 07:56:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9480A1FB1
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 07:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6066C4339B;
	Mon, 15 May 2023 07:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684137371;
	bh=aGgV8Fk04aAxsyOUuSaRSanh/M61ws8l+egjAA63JEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DRbT+LD3eZeE3bb78D4ENbrLYyruc0VB05g6A3XVz/A8f42NG+eVmTro+cDPHRCmI
	 ifOG/soIJAQb98B5pcli3153TufH3D/Ep8nz9fXmne5d2wyF5hx2jvUvsWPLNlxBNM
	 jMMr97NRdNH8TYS3oKZITNgnFLRVMJapZmmziJKAYDjXKUtJSN28Ky5sLhO5eLiRHj
	 L5XM+MZgmEhr6M31rsEEt9BUTRAyqCWOheVHuiCCRXDrJd0pjtoIudxlfrmLIF2uND
	 s/oTKbORppXfrlgQxfOCeAGkHjZXzOho3/cg2G6+jTgxOIrRp+r161JWrKV6S2JYz6
	 XytN95rtafznw==
Date: Mon, 15 May 2023 09:56:06 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v4 6/9] fs: use new capable_any functionality
Message-ID: <20230515-disqualifikation-ununterbrochen-c0f15f4efdd1@brauner>
References: <20230511142535.732324-1-cgzones@googlemail.com>
 <20230511142535.732324-6-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230511142535.732324-6-cgzones@googlemail.com>

On Thu, May 11, 2023 at 04:25:29PM +0200, Christian Göttsche wrote:
> Use the new added capable_any function in appropriate cases, where a
> task is required to have any of two capabilities.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>

