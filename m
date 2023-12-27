Return-Path: <bpf+bounces-18697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5333081EFDC
	for <lists+bpf@lfdr.de>; Wed, 27 Dec 2023 16:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FE10282643
	for <lists+bpf@lfdr.de>; Wed, 27 Dec 2023 15:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341AF45BE2;
	Wed, 27 Dec 2023 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OU8lD5Yc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826E245964;
	Wed, 27 Dec 2023 15:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A88AC433C8;
	Wed, 27 Dec 2023 15:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703692005;
	bh=FVAzF6daxQ8ZuqevGdpKsQkUqo5vlGmUhgShjqY2IPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OU8lD5YcV1tfKJkMESk+txqJXvn3t/8JgQEc7mTFFs3PJBN4Fb8bk0tfsP7J69YST
	 66B0F0SU7qZYkASqGaSeQWALbSlKEZn2U8NWrPF37lF8NiFMXYpsGV+rW4qQrxcicV
	 eUbzg6CG4usuT6OujzN7Pc/RFHtb16rnr2FSe3Rw=
Date: Wed, 27 Dec 2023 15:46:41 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
	linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	David Vernet <void@manifault.com>, Jiri Kosina <jikos@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: HID: bpf: One function call less in call_hid_bpf_rdesc_fixup()
 after error detection
Message-ID: <2023122719-stunt-duration-9504@gregkh>
References: <3203eb44-6e69-4bda-b585-426408cb75ee@web.de>
 <618f886f-b2ff-4d50-cf74-e8478a7e8547@huaweicloud.com>
 <b75d66cc-a507-432a-af60-655950671b8a@web.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b75d66cc-a507-432a-af60-655950671b8a@web.de>

On Wed, Dec 27, 2023 at 09:19:27AM +0100, Markus Elfring wrote:
> >> The kfree() function was called in one case by the
> >> call_hid_bpf_rdesc_fixup() function during error handling
> >> even if the passed data structure member contained a null pointer.
> >> This issue was detected by using the Coccinelle software.
> >
> > It is totally OK to free a null pointer through kfree() and the ENOMEM
> > case is an unlikely case, so I don't think the patch is necessary.
> 
> Would you ever like to avoid redundant data processing a bit more?


Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

