Return-Path: <bpf+bounces-61537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7C2AE87C1
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 17:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75BB25A6B2A
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 15:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9551326A0C6;
	Wed, 25 Jun 2025 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="L4+sWOmk"
X-Original-To: bpf@vger.kernel.org
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB9210942
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 15:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750864679; cv=none; b=axS90+yaZI5F7H/8GTxpF0uI6AalmmD/GB9t8AheuliLD+T9RS14d/ovvmyGYh86A2y2iyoj8xJTEuZCh1pFAdvZX+HOue/4OYetGfopaPlpcPNgrf8WTRb8eWOrXd1AtHDiu/z7au2saTnLd5FM0Eube7Vj55xW42sgjJghznc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750864679; c=relaxed/simple;
	bh=Fvd26E75Wxh8YAdVWxsdU5D3V4beWONR31TvOY0KB3o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LUJ/7nVRK12RcYmExZdjePogeR2ffaOZBXrfxOhzO/MXzMRaRIlcXqpCrk8eDMTI8D1en6NGd4wubdg8xPhk12zSv6UwzEOm3TPjt7Qa38yyLND/04pfPWvYCm2XkhGLe4gc8v0AjG7jixR3y0ozY2h+y/ceS3MySV+zzX/z6wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=L4+sWOmk; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <jemarch@gnu.org>)
	id 1uURsp-0004CO-Ev
	for bpf@vger.kernel.org; Wed, 25 Jun 2025 11:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
	references; bh=mNRSybVN5CPgIfvzpT1Prsog/QfqaTi8eWVPwSEFGAI=; b=L4+sWOmkLPhNfs
	m1KYzXLjSDo8VDXeAXj9dvcXXlVbbEp7zc27WiNsvbE93A6+BcJJ3wqMt0jimgbkodc1RLDZun+9Y
	tYOt6u/CJHC5teM0PPGnXKVIcsfx2Rn6oIzkyrLnytuU8LWa3QdMz15/DrqUxzYU65XVegqpgH2P1
	zlFBFHqv7PXGKDRF7mqj5Q2sHcM3knhsvFJl+KHc/3dlK7AnpLW7vZk/VJ/YLlMmBlcjO/zKKLlaL
	P/JrIWcoQRZMXMV0cSygFPucoZSl+rBRUFZhDy1DVe9bx3eSFrfG44wlCeXPDhHBEc/MwXu+3QFwY
	W48tZk0ZUpbJDJCIFsjw==;
From: "Jose E. Marchesi" <jemarch@gnu.org>
To: bpf@vger.kernel.org
Subject: [FYI] GNU Tools Cauldron 2025
Date: Wed, 25 Jun 2025 17:17:45 +0200
Message-ID: <87plerg89y.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hello,
we are pleased to invite you all to the next GNU Tools Cauldron,
taking place in Porto, Portugal, on September 26-28, 2025.

This year we have a new website that has all the details of the event:

  https://gnu-tools-cauldron.org/

Among other things, where you will find links to a pretalx where you
can submit and/or edit your proposals, purchase of conference tickets,
the schedule of the event once it is ready and published, sponsor
information, and instructions on how to contact the organizing
committe and the CoC committee.

Note that the ticketing system is not online yet, as we are still
rounding up some details.  It will be available very soon.  You can
expect the price of the ticket to be around 80 GBP.  For any enquiry
on ticketing please feel free to contact the organizing committee.

The GNU Toolchain Fund (https://gcc.gnu.org/wiki/GNUToolchainFund)
sponsors developer travel to attend the GNU Tools Cauldron.  Having
developers meet face to face is important and builds connections in
our communities.

For all details of how to register, and how to submit a proposal for a
track session, please see the web page.

This year's Cauldron is organized by a group of volunteers in
cooperation with the Faculdade de Engenharia da Universidade do Porto
(FEUP).

This announcement is being sent to the main mailing list of the
following groups: GCC, GDB, binutils, CGEN, DejaGnu, newlib, glibc,
poke, libabigail and elfutils.

Please feel free to share with other groups as appropriate.

jemarch (on behalf of the GNU Tools Cauldron organizing committee).

