Return-Path: <bpf+bounces-27061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74C78A8AD4
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 20:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88C31C21B8C
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 18:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB307173357;
	Wed, 17 Apr 2024 18:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="qlNu+Ipj"
X-Original-To: bpf@vger.kernel.org
Received: from ha.d.sender-sib.com (ha.d.sender-sib.com [77.32.148.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77E8129A7F
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 18:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.32.148.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713377362; cv=none; b=QDy/G+j0uo5m1iQ+fPfKgebCIxrzlEjUGfk2S4J+TF6vP8Jw1O1G+OHac/kJi33UaR+gCz9O3hb10vr8NchLGs2WAqg4Znp/xTjxiOxm76dS29Rvv9LtDgJ2Xps+qJY9DPeDsXloo3OF93st0TzfpvL8aH4/TOKRc0K8shHNzAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713377362; c=relaxed/simple;
	bh=4BLog3mlsIr03NHRQZtEKLNszHS8iKJiXzjzhO7p9QI=;
	h=Date:Subject:Mime-Version:Cc:Message-Id:To:From; b=Sb99SjpcVYefo5NPgVOkwJaWzfkV74C5Ncifa/FsKy34APHAP5II0ZpQwzD+AKFtftvxBfGOXsv4OnIKqvzacfvdJLopXbALoicuVlkT+usTFjVmq2aZjkDstBtAKczXZJWxFIQRWh0N1bxrnvDHoPFJWw1Lsl+HAjeY4VaVH8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=ha.d.sender-sib.com; dkim=pass (1024-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=qlNu+Ipj; arc=none smtp.client-ip=77.32.148.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ha.d.sender-sib.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rcpassos.me;
 q=dns/txt; s=mail; bh=JPRyWTfC0iWaFxCMF/E8UqPDmTa6ghn5FbVHzoW/CfA=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:x-csa-complaints:list-unsubscribe-post;
        b=qlNu+IpjKy6us5VFrS8Wr/1c4L66J5tFOP+loo/qP8YGXyNddFAgzPghDbYb1+RE2b5awsJRi0vb
        80hI91zISnLQh0E64nX2p19DWIA6s6ELQvJ7aWqkBDPj5eCw2RtbtAk5CuI8/9wP4IJQenW6953J
        sj2YYK1srsy+G4XJQIQ=
Received: by smtp-relay.sendinblue.com with ESMTP id c195ba81-bdd7-4412-9cd5-8cebe4efd4f3; Wed, 17 April 2024 18:08:11 +0000 (UTC)
X-Mailin-EID: MjM2NzcxMDk4fmJwZkB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwNDE3MTgwNDQ2LjkzMDAtMS1yYWZhZWxAcmNwYXNzb3MubWU%2BfmhhLmQuc2VuZGVyLXNpYi5jb20%3D
Date: Wed, 17 Apr 2024 14:52:23 -0300
Subject: [PATCH bpf-next 0/2] bpf: fixes typos in kernel/bpf files
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Cc: "Rafael Passos" <rafael@rcpassos.me>, bpf@vger.kernel.org
Message-Id: <c195ba81-bdd7-4412-9cd5-8cebe4efd4f3@smtp-relay.sendinblue.com>
Origin-messageId: <20240417180446.9300-1-rafael@rcpassos.me>
To: <andrii@kernel.org>,<ast@kernel.org>,<daniel@iogearbox.net>
X-sib-id: gdUJnEkhgIl0LxmRMw9gJREnC6TzeClQgmx4nDUBZcPGkpSaMg4YVcmkGMAploDW8XSyuiCLmU2nDfSM3JykuT6xtEo8R-prOklnLzWnvMoAhXrZRl0ozMo5IKQI4av-7Q3wQZO_6DJNOtYeyqqnMxf2ZtxokT66a6d0PZdqeIN0
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 77.32.148.27:6736438_-1:6736438:Sendinblue
From: "Rafael Passos" <rafael@rcpassos.me>

This patchset fixes some typos in comments, and a function parameter.
It is my first contribution. I am reading this codebse to contribute
more in the future. I hope evething is ok, and I am open to feedbacks.
Thanks

Rafael Passos (2):
  bpf: fixes typos in comments
  bpf: fix typo in function save=5Faux=5Fptr=5Ftype=20

 kernel/bpf/bpf=5Flocal=5Fstorage.c |  2 +-
 kernel/bpf/core.c              |  2 +-
 kernel/bpf/hashtab.c           |  2 +-
 kernel/bpf/helpers.c           |  2 +-
 kernel/bpf/verifier.c          | 18 +++++++++---------
 5 files changed, 13 insertions(+), 13 deletions(-)

--=20
2.44.0



