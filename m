Return-Path: <bpf+bounces-48589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECAFA09D21
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 22:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714ED3A88ED
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 21:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6138208997;
	Fri, 10 Jan 2025 21:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="N5kfpBUD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xjN0zoXG"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2921A23B0
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736544210; cv=none; b=DYwz7wZ4ILvmFjE3dTvvkzauS3NxBCVudOrt7nVJYEEEL2NbCUC6mabXRhfQLP2B9qY32N0VSzMXYX6MTW07e8b3n9c+wZ58+SmcaNzG4ZCMo7aCfJlMI0oWajuHqFVtY32NL8eGxYwZ52duo5efZuuc6PuClWFUQmh1cAK3m88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736544210; c=relaxed/simple;
	bh=R7DIyLosg686CcsSRk/5MJprWHWXZhwTnKnynz4eAGI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QJIOMphkGyStAyYGBdy+j9WBhtgRkJPCSYVEqX8ZmsCQ+rjLNlmwxX2wu/LEu17HWLstJ3ntJJ6W3Zqye/jw688BTe20U1HX5FX6LCWOtmUXdhDy6gPHYCRm1s60iFD0kBoYeJ67XBMt/s3ZAltPoqx09jGfySe2ZRHoQWwgzzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=N5kfpBUD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xjN0zoXG; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 06A9C254005F;
	Fri, 10 Jan 2025 16:23:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 10 Jan 2025 16:23:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1736544201; x=1736630601; bh=7O
	ks7w2T3ndadqclTzXJPuoexJnAMWG/oN0gLyIc3B0=; b=N5kfpBUDF2U76DcM+G
	LsccdYOpnLsjPLd88PmbIxcPTnva9myQN9gcL2UjGLTcm860ezDmejPlvSlKlA5K
	LwJcvkHTKe+l/zXJ97k8nj1Y5W/3DzQgyIpnfBe6kYZ8owKcmIM7JpyZPWUZdmA/
	sJQRHukH9saRTItIjflzUii6whdiGVlZh7fhpPZ3+FNF6qlcKfmAyRBulG9O96No
	EW9I2XY+zRsLnxlQhoYIPb08rEkUDUVlHrF5or+eAKijKuEvwn+raHyCTsTa2JQa
	VZmb+TFVjXgO6Ifc6G4/F+RNjz57jlqovPIxvCGBv1k3a2AzeAHKPqgA/aVgYGNr
	S31g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1736544201; x=1736630601; bh=7Oks7w2T3ndadqclTzXJPuoexJnA
	MWG/oN0gLyIc3B0=; b=xjN0zoXGJZJHbS2btbl+TMsBOipIrYe0ZH0fBBt5h+Yu
	rlfKV/TejMmeEYnvPxkxevs3a6mdW39ICYCeL1LKINflcG1lFhgq+guJtGjFGyd6
	veQwLa+bNKsbgVk0FDlY9zyQrGlrke4w0Zyzz80cQSxQ493Eg68y2x8zk8Bx65Br
	GPPD3iVgpodGpaZu7+gutJFblfXhiU+05vgIz5gErwBgnelsAezXPeGYvXdfYI/9
	oQjTSd01aAD96d/v/LZPKE1sPMyh3GS1nR4JlDZMszX7kBUFu/hnQmu0F/szD8cG
	V+y54bdNFHdOaeo+JNoEa05Bz6DfUtlXtJTa/i4Orw==
X-ME-Sender: <xms:yY-BZ8EehEfCRWBfh05eXNzbmL1VNXSOnhBltwFP4he4Eo2qijwWwA>
    <xme:yY-BZ1WaxCYsTAlzu5RTluq8G2Ex2279q9ZmyOc1lXcqi-HULE0rEpPQfv0FWUrFJ
    ekimvpU5zHuEvxRYg>
X-ME-Received: <xmr:yY-BZ2JsGhipyICzzm3o5PL7f6tjyoF-6yQtanSehIJQhIAQJRBoJaWT2V_2hAsrVUKe0NNmcSlC-nP0_h52RxVWNg6nGD2DNu08TTiMmBNurw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculd
    efhedmnecujfgurhepfffhvfevuffkgggtugfgsehtkefstddttdejnecuhfhrohhmpeff
    rghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnh
    epgeefvdejledvffeiteffteehheevgfevjeehgefgtdffjeegtddtledvudejvedvnecu
    ffhomhgrihhnpehllhhvmhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggprhgtphhtthho
    pedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlshhfqdhptgeslhhishhtsh
    drlhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsghpfhesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yY-BZ-Gd2ytzhVz4NgaColPVXEUx0Hg58ZYmbRrZ467ZPrHmknSX1g>
    <xmx:yY-BZyUjCuJ9bVaXcB-x4wUrxadKRIMmAEqnFLWSl0-CI_QTcS25bA>
    <xmx:yY-BZxPR5lZHa5dX99jBgJN0quTHeUHHXORon7Mc__WNzODw_dmkGw>
    <xmx:yY-BZ52oPwqIWMBAsRAed5oFaYCVMP9chyo-wLL6oKzHOFcD7RLkKA>
    <xmx:yY-BZ_iPRjt1x7vE-WKLv37daEX-oy_t2OIK-ssQQq9U_4Lyc_HWdhQA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 16:23:20 -0500 (EST)
Date: Fri, 10 Jan 2025 14:23:19 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: lsf-pc@lists.linux-foundation.org
Cc: bpf@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Modular BPF verifier
Message-ID: <nahst74z46ov7ii3vmriyhk25zo6tkf2f3hsulzjzselvobbbu@pqn6wfdibwqb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi folks,

I'd like to propose modular BPF verifier as a discussion topic.

=== Motivation ===

A decade of production experience with BPF has shown that the desire for
feature availability outpaces the ability to deliver new kernels into the field
[0]. Therefore, the idea of modularizing the BPF subsystem into a loadable
kernel module (LKM) has started to look appealing, as this would allow loading
newer versions of the BPF subsystem onto older versions of the kernel without a
reboot.

That being said, the BPF subsystem is large and complex. It is not practical to
try and solve the entire problem all at once. So the question is: where do we
start? Proposal: the verifier, because it is high value and architecturally
sympathetic to modularization.

**High value**: It is straightforward to reason about functionality delivered
through kfuncs, helpers, or maps. If feature A exists, codepath X is taken;
else, codepath Y. This is generally not practical with verifier improvements -
bugs or limitations there are far more difficult to reason about. Complexity
grows sharply when applications support many kernel versions. Maintaining a
minimal set of cutting edge verifiers in the field is a value-add in the form
of enablement, reliability, and simplicity.

**Architecturally sympathetic**: The verifier is architecturally a “pure
function” [1].  Pure functions are easy to hot swap, as state transfers are not
necessary.  Because of the verifier’s current design, large re-architecting
will not be necessary for modularization. This means modular verifier is
primarily a refactoring project and can lean on the existing test suite, making
it a good first target.

If successful, a modular verifier gives us experience as well develops a
toolkit of techniques that can be applied to the subsystem at large.

=== Goal ===

The goal is to refactor the verifier into an LKM with an eye towards forward
compatibility.

=== Design ===

[[ The following is an rough design based on early research. I expect it to ]]
[[ change as I gather feedback and do more prototyping work. Nothing is set ]]
[[ in stone.                                                                ]]

For forward compatibility, the idea is to implement a facade built into each
kernel that exposes a stable-enough (non-UAPI) interface such that the verifier
can remain portable and “plug in” to the running kernel. While I expect the
facade to be necessary, it will not be sufficient. There will eventually be
details the facade cannot hide, for example an unavoidable ABI break. To solve
for this, I/we [2] will maintain a continuously exported copy of the verifier
code in a separate repository. From there we can develop branching, patching,
or backport strategies to mitigate breaks. The exact details are TBD and will
become more clear as work progresses.

On top of delivering newer verifiers to older kernels, the facade opens the
door to running the verifier in userspace. If the verifier becomes sufficiently
portable, we can implement a userspace facade and plug the verifier in. A
possible use case could be integrating the verifier into Clang [3] for tightly
integrated verifier feedback. This would address a long running pain point with
BPF development. This is a lot easier said than done, so consider this highly
speculative.

The facade exists as a cooperative mechanism. While it might technically be
possible to do a non-cooperative modularization of the verifier through
aggressive patching and no kernel changes, it seems unnecessarily complex given
the alternative. Completion of the facade does not block deployment - the
facade seeks to reduce the chance of stranding older kernels with newer
verifier changes.

=== Footnotes ===

[0]: Disclaimer: this is not intended to be a criticism of anything - merely to
point out the fact that the kernel as a singular delivery vehicle leaves a lot
on the table.

[1]: Perhaps not in practice today, but deeper integration with the rest of the
kernel can probably be cleaned up and abstracted.

[2]: It's likely more people will be involved if modular verifier proves to be
viable.

[3]: https://clang.llvm.org/docs/ClangPlugins.html

