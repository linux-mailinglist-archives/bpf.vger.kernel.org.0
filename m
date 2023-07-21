Return-Path: <bpf+bounces-5603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F0775C567
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 13:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035A61C21692
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 11:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DB01D2E5;
	Fri, 21 Jul 2023 11:05:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF3B1D2E0
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 11:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CB4C433C8;
	Fri, 21 Jul 2023 11:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1689937528;
	bh=brpYjN67pi8vb1CUOrN2PHPx/mEamwOtSETypKPcc3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y0u1ilGD1ky32ubAL1uuECjAQzvl0vKiwN6U1V9XRTa484M4MLATg2/WUSqMhPVSq
	 lLlVfbIaHbrtPmMl7OJ34QFWVgGXxe0J8vpR6h0f2TTSvn057aWvxjmbxxOdgip3l4
	 04Bj/7MLsnwklxAVEZyruTKZRh5C/hMMBw1K+Wzs=
Date: Fri, 21 Jul 2023 13:05:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Yan <eric.yan@oppo.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, sdf@google.com,
	nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
	keescook@chromium.org, samitolvanen@google.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CFI: fix panic in kernel bpf map traversal
Message-ID: <2023072113-sanding-able-e4a2@gregkh>
References: <20230721103411.19535-1-eric.yan@oppo.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230721103411.19535-1-eric.yan@oppo.com>

On Fri, Jul 21, 2023 at 06:34:11PM +0800, Eric Yan wrote:
> ________________________________
> OPPO
> 
> 本电子邮件及其附件含有OPPO公司的保密信息，仅限于邮件指明的收件人（包含个人及群组）使用。禁止任何人在未经授权的情况下以任何形式使用。如果您错收了本邮件，切勿传播、分发、复制、印刷或使用本邮件之任何部分或其所载之任何内容，并请立即以电子邮件通知发件人并删除本邮件及其附件。
> 网络通讯固有缺陷可能导致邮件被截留、修改、丢失、破坏或包含计算机病毒等不安全情况，OPPO对此类错误或遗漏而引致之任何损失概不承担责任并保留与本邮件相关之一切权利。
> 除非明确说明，本邮件及其附件无意作为在任何国家或地区之要约、招揽或承诺，亦无意作为任何交易或合同之正式确认。 发件人、其所属机构或所属机构之关联机构或任何上述机构之股东、董事、高级管理人员、员工或其他任何人（以下称“发件人”或“OPPO”）不因本邮件之误送而放弃其所享之任何权利，亦不对因故意或过失使用该等信息而引发或可能引发的损失承担任何责任。
> 文化差异披露：因全球文化差异影响，单纯以YES\OK或其他简单词汇的回复并不构成发件人对任何交易或合同之正式确认或接受，请与发件人再次确认以获得明确书面意见。发件人不对任何受文化差异影响而导致故意或错误使用该等信息所造成的任何直接或间接损害承担责任。
> This e-mail and its attachments contain confidential information from OPPO, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you are not the intended recipient, please do not read, copy, distribute, or use this information. If you have received this transmission in error, please notify the sender immediately by reply e-mail and then delete this message.
> Electronic communications may contain computer viruses or other defects inherently, may not be accurately and/or timely transmitted to other systems, or may be intercepted, modified ,delayed, deleted or interfered. OPPO shall not be liable for any damages that arise or may arise from such matter and reserves all rights in connection with the email.
> Unless expressly stated, this e-mail and its attachments are provided without any warranty, acceptance or promise of any kind in any country or region, nor constitute a formal confirmation or acceptance of any transaction or contract. The sender, together with its affiliates or any shareholder, director, officer, employee or any other person of any such institution (hereinafter referred to as "sender" or "OPPO") does not waive any rights and shall not be liable for any damages that arise or may arise from the intentional or negligent use of such information.
> Cultural Differences Disclosure: Due to global cultural differences, any reply with only YES\OK or other simple words does not constitute any confirmation or acceptance of any transaction or contract, please confirm with the sender again to ensure clear opinion in written form. The sender shall not be responsible for any direct or indirect damages resulting from the intentional or misuse of such information.
> 

Now deleted.

