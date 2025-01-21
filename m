Return-Path: <bpf+bounces-49402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52684A18249
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 17:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92BBA1686E9
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 16:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948791F4297;
	Tue, 21 Jan 2025 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7D3j8VJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC77913BC0C
	for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737478253; cv=none; b=BQAa5BcShsy4Hv9Qmgccf5SoqI+sHlFxxCdRjfdbbs0J1RywCNhUooOV49645m1TVzkUKIJSN3uGd4+55yYhu/JI3flU8Jo0u+F7gFD2MhokygvaRbWHz2vEWNT1mhcZdCday1wP1fBYJgPJddVyYf/R2liODZ7ITICS9SfCElg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737478253; c=relaxed/simple;
	bh=SsXmSGW57WprIatXJQU3GgUJc0Iq3+wXch4RgUbJtpY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=sKu/gYxyXAsGkDeUIJrT9X4hlc/gudIfYad6APzV4Fpw3ahKmIJJzcdSs2KhDVwD6DZsWrO8+BeBt0WxMB9idF7JZlJqLVFCPCjlScEaWDQuyWeMMKa95WkImi6SCacRaqj2eNTYJIMQdLS837JQ7ykqIjtNPW3e8waEvJ/hDMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7D3j8VJ; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5f33ad7d6faso3747698eaf.0
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 08:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737478250; x=1738083050; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qIrDR2ZN/EUQN3BtPjqgq3XG3zWYH9SNKP4tKdFLz20=;
        b=k7D3j8VJ67+ikfDDLDtbZOND5N2QJEaaXhB/bZx3BPV7JGEJy5Rf4nDzq1N+4M36Jo
         DNhBH4x13buUK8YYRBmD/52XGvM6JowgeqXdPfitr0hbxoRHxdWPb7Ebqw/FuztHKxJl
         Ag7MedzYScc09iNNSfvCSwZkX85f4iHy2f7JOnYbARpR2apSVYRsrBFxA7pJiIKSTvPV
         h4nUEPi9EOXyWd2OkyYI8G2zk9sH3iLHo83JlNyf978BnlJ3YWxbYAluHiwcNJUHR+HU
         fcLVK04njeHNXyNFYk3Cc82gogBqV5tq5sfobBAGVBefQf5+gtjJAoiSDWOVESlbiLvN
         fVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737478250; x=1738083050;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qIrDR2ZN/EUQN3BtPjqgq3XG3zWYH9SNKP4tKdFLz20=;
        b=lMjdZSLk5L82MZt51SYLsEge7w9fJnvoe/vUvfi6LmGbx7FxqNXZaYJML7BusCJTP9
         M/oQFSV+Sbcr7/9EXs1CTNLGA/OuLkdggqcA9a7CM4/j4f87DI5IceOOXOU0x2sb9A/W
         p3ynahSHdXL4n8ZQQCc4c81MQsXw3qelgA7JQLZ2e8cFQK2X/6Y9TrBQgG3lCdi5YCeN
         LPXKEa/8PaYFtYvD2dMVD4VBj0iHItSX/UMSXUpA+bnE3J1dIdhEDMyl1+TawDnLmAT/
         cHs/nG0hZ+Q3mObjjpK4VygBqlWjh891O4ZfjYCa/QkwtEgMjLq2e6DlVdGD6XlGgWh8
         is6Q==
X-Gm-Message-State: AOJu0YwwMpoT6w46eoVgXORS9skTocVEIPAKVLqsBKMG2So3kXVDFQdw
	IdUKygGkrTn7D472TRRPkm0KAavI3pXqmC5Kft1AT8lZTUoA2w0xWpyFJ+jrIa/ly9qXA5GH054
	H3fbR7tTKOmmRtwwoV0ACzH19FseI/g==
X-Gm-Gg: ASbGncsbHrkplSBbm06ts1Gq+PZzynuhOH2XWWn9vrC9aYXc/28BnvQAY3383jWnHnB
	gDnsuuXlyLhb5lBfPFy1gb2IMbUOe9ntiiKnsVza766ohlE3a9g==
X-Google-Smtp-Source: AGHT+IFJKo9XDHWURrrlprj329eayn4UoDqadyTZu2AiZrVqBxxqp3rUzXRijSuv6Db64xYbIi73COhgPjWbLlNSLmY=
X-Received: by 2002:a05:6820:2706:b0:5f6:6547:8a0f with SMTP id
 006d021491bc7-5fa3887bbfamr10970193eaf.6.1737478250416; Tue, 21 Jan 2025
 08:50:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 21 Jan 2025 16:50:39 +0000
X-Gm-Features: AbW1kvaYwkyOzt09tAYe3f5VvhOJyqoKd6xI-qw9BiRuuyvxROzxpoqpzMVhWfg
Message-ID: <CA+XhMqyt7LGkitBrNE1goRMQdsP23=BwLsCor0pY+mM6zO2+zg@mail.gmail.com>
Subject: [PATCH bpf-next 1/1]
To: bpf@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ec2831062c3a2db5"

--000000000000ec2831062c3a2db5
Content-Type: multipart/alternative; boundary="000000000000ec2830062c3a2db3"

--000000000000ec2830062c3a2db3
Content-Type: text/plain; charset="UTF-8"

libbpf.c memory leaks fixes proposal.

--000000000000ec2830062c3a2db3
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">libbpf.c memory leaks fixes proposal.<br></div>

--000000000000ec2830062c3a2db3--
--000000000000ec2831062c3a2db5
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-libbpf.c-bpf_program__attach_uprobe_opts-fix-possibl.patch"
Content-Disposition: attachment; 
	filename="0001-libbpf.c-bpf_program__attach_uprobe_opts-fix-possibl.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m66pn5gd0>
X-Attachment-Id: f_m66pn5gd0

RnJvbSAzODFhZTUxMzY3MWVhMjE0ZjBmNmEwNGNhOWRhNzVkZmU0NDExNjgzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZpZCBDYXJsaWVyIDxkZXZuZXhlbkBnbWFpbC5jb20+CkRh
dGU6IFNhdCwgMTggSmFuIDIwMjUgMTA6MzA6MzkgKzAwMDAKU3ViamVjdDogW1BBVENIXSBsaWJi
cGYuYzogYnBmX3Byb2dyYW1fX2F0dGFjaF91cHJvYmVfb3B0cyBmaXggcG9zc2libGUgbWVtb3J5
CiBsZWFrcy4KCmJwZl9wcm9ncmFtX19hdHRhY2hfcGVyZl9ldmVudF9vcHRzKCkgbWlnaHQgYmUg
bm90IGVub3VnaCB0byBjbG9zZQp0aGUgZmlsZSBkZXNjcmlwdG9yLCBicHRfbGlua19fZGVzdHJv
eSgpIGRvZXMgYSBtb3JlIHRob3JvdWdoCmNsZWFuIHVwIGluY2x1ZGluZyBpdHMgaW5uZXIgZmls
ZSBkZXNjcmlwdG9yLgpBcHBseWluZyB0bwpicGZfcHJvZ3JhbV9fYXR0YWNoX2twcm9iZV9vcHRz
L2JwZl9wcm9ncmFtX19hdHRhY2hfdHJhY2Vwb2ludHNfb3B0cwp0b28uCgpTaWduZWQtb2ZmLWJ5
OiBEYXZpZCBDYXJsaWVyIDxkZXZuZXhlbkBnbWFpbC5jb20+Ci0tLQogc3JjL2xpYmJwZi5jIHwg
NiArKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvc3JjL2xpYmJwZi5jIGIvc3JjL2xpYmJwZi5jCmluZGV4IDE5NDgwOWQu
LmU1NzE2NzUgMTAwNjQ0Ci0tLSBhL3NyYy9saWJicGYuYworKysgYi9zcmMvbGliYnBmLmMKQEAg
LTExMjcxLDcgKzExMjcxLDcgQEAgYnBmX3Byb2dyYW1fX2F0dGFjaF9rcHJvYmVfb3B0cyhjb25z
dCBzdHJ1Y3QgYnBmX3Byb2dyYW0gKnByb2csCiAJbGluayA9IGJwZl9wcm9ncmFtX19hdHRhY2hf
cGVyZl9ldmVudF9vcHRzKHByb2csIHBmZCwgJnBlX29wdHMpOwogCWVyciA9IGxpYmJwZl9nZXRf
ZXJyb3IobGluayk7CiAJaWYgKGVycikgewotCQljbG9zZShwZmQpOworCQlicGZfbGlua19fZGVz
dHJveShsaW5rKTsKIAkJcHJfd2FybigicHJvZyAnJXMnOiBmYWlsZWQgdG8gYXR0YWNoIHRvICVz
ICclcysweCV6eCc6ICVzXG4iLAogCQkJcHJvZy0+bmFtZSwgcmV0cHJvYmUgPyAia3JldHByb2Jl
IiA6ICJrcHJvYmUiLAogCQkJZnVuY19uYW1lLCBvZmZzZXQsCkBAIC0xMjI1OSw3ICsxMjI1OSw3
IEBAIGJwZl9wcm9ncmFtX19hdHRhY2hfdXByb2JlX29wdHMoY29uc3Qgc3RydWN0IGJwZl9wcm9n
cmFtICpwcm9nLCBwaWRfdCBwaWQsCiAJbGluayA9IGJwZl9wcm9ncmFtX19hdHRhY2hfcGVyZl9l
dmVudF9vcHRzKHByb2csIHBmZCwgJnBlX29wdHMpOwogCWVyciA9IGxpYmJwZl9nZXRfZXJyb3Io
bGluayk7CiAJaWYgKGVycikgewotCQljbG9zZShwZmQpOworCQlicGZfbGlua19fZGVzdHJveShs
aW5rKTsKIAkJcHJfd2FybigicHJvZyAnJXMnOiBmYWlsZWQgdG8gYXR0YWNoIHRvICVzICclczow
eCV6eCc6ICVzXG4iLAogCQkJcHJvZy0+bmFtZSwgcmV0cHJvYmUgPyAidXJldHByb2JlIiA6ICJ1
cHJvYmUiLAogCQkJYmluYXJ5X3BhdGgsIGZ1bmNfb2Zmc2V0LApAQCAtMTI1MTQsNyArMTI1MTQs
NyBAQCBzdHJ1Y3QgYnBmX2xpbmsgKmJwZl9wcm9ncmFtX19hdHRhY2hfdHJhY2Vwb2ludF9vcHRz
KGNvbnN0IHN0cnVjdCBicGZfcHJvZ3JhbSAqcAogCWxpbmsgPSBicGZfcHJvZ3JhbV9fYXR0YWNo
X3BlcmZfZXZlbnRfb3B0cyhwcm9nLCBwZmQsICZwZV9vcHRzKTsKIAllcnIgPSBsaWJicGZfZ2V0
X2Vycm9yKGxpbmspOwogCWlmIChlcnIpIHsKLQkJY2xvc2UocGZkKTsKKwkJYnBmX2xpbmtfX2Rl
c3Ryb3kobGluayk7CiAJCXByX3dhcm4oInByb2cgJyVzJzogZmFpbGVkIHRvIGF0dGFjaCB0byB0
cmFjZXBvaW50ICclcy8lcyc6ICVzXG4iLAogCQkJcHJvZy0+bmFtZSwgdHBfY2F0ZWdvcnksIHRw
X25hbWUsCiAJCQllcnJzdHIoZXJyKSk7Ci0tIAoyLjQ3LjIKCg==
--000000000000ec2831062c3a2db5--

