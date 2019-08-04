Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A293780A16
	for <lists+bpf@lfdr.de>; Sun,  4 Aug 2019 11:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfHDJcN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Aug 2019 05:32:13 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:45159 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfHDJcN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Aug 2019 05:32:13 -0400
Received: by mail-ot1-f43.google.com with SMTP id x21so16958049otq.12
        for <bpf@vger.kernel.org>; Sun, 04 Aug 2019 02:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neemtree-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=PkIjItspvlzL3MIvn5T4oDSXBWJakBLUUY8UsQhh7SU=;
        b=iUNLg7eVJ4N0CqqAtrKvyH2xWy29fJ2coOnPgm6odeV+aLfyjh7Nul1K6LvbY/jVAB
         P6yBRdFahOtdNMAmPeILEIRCYmBv+61yrg3USuxyuMBcb7aP5TyFEU+QMOgwxuWd5CWm
         lip2UjB5IzyKI5aztRqddPQzbPLtN1vqoTbW3Fv6PM7sRhX3pi6n2mCaNVoCN3cU9BXC
         x8APDDRQRB2dwD2eEJcpObNhJoxNih6rRc3pvhjAGn40EH6V1CAMDFmOXqdF63H4spSr
         zikp+oitZCfMvJ3Jq+j6o6uOi+D3AN1ExZV3BLH3OW/gQMTA4MvfPPlvFRwLwprM6+Y2
         nIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PkIjItspvlzL3MIvn5T4oDSXBWJakBLUUY8UsQhh7SU=;
        b=WyF0OB2lzmuB+QUE0MPy4e0+gbZSpXTci831hcAlpvOsYafDawsaHVwNWTfC5p7r8z
         wkNkhbbrsJa4Lgwy4PfwfSDo1AN0d1KWP4mzeDBPmHyTOLYty3stTQRQrHd+/0TWWqT1
         zGErVzAUJy/Z5TlbZocz9Oq5QAcdJMvqums/PWMyMHZYXF152vm383gBSIQIto2i5361
         lT18W3WHV1ayZPSdfs/I7HCgwACSP5y2AeWkCa7OphH62C+/r1pdhkrskYsr1gJlorHz
         6LiZYPbsZj9BZZfaRTpiw2S5iSoZLg2vA+nOFniw+h62aYFf/mQtXTFMur/t0+M8xTnX
         i6kg==
X-Gm-Message-State: APjAAAVOXEJNXi5AcxUrBFWDGFQXIWZViy/u+AxGP5XiOBCIusVhEo22
        OntIlloUU2nLVqVpN/zz70sqdyrpJdvuXL0mGnFgNQfH
X-Google-Smtp-Source: APXvYqyMX3auQ6WmhHH7NDt3CoqhXiTTPXheamAomeIM0Je6ukvZ7/gZw8YELeoRChCxBVyQmjuvDj/dL7ZmSfW913U=
X-Received: by 2002:a9d:5788:: with SMTP id q8mr6694890oth.237.1564911131753;
 Sun, 04 Aug 2019 02:32:11 -0700 (PDT)
MIME-Version: 1.0
From:   Shridhar Venkatraman <shridhar@neemtree.com>
Date:   Sun, 4 Aug 2019 15:01:58 +0530
Message-ID: <CADJe1ZsN8+1brBNdN2VNMp4PRdeYjCC=qaMZALQxOTvPmgJQhA@mail.gmail.com>
Subject: BPF: ETLS: RECV FLOW
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

The eTLS work has BPF integration which is great.
However there is one spot where access to the clear text is not available.

From kernel 4.20 - receiver BPF support added for KTLS.

a. receiver BPF is applied on encrypted message
b. after applying BPF, message is decrypted
c. BPF run logic on the decrypted plain message   - can we add this support ?
d. then copy the decrypted message back to userspace.

code flow reference: tls receive message call flow:
--------------------------------------------------------------

tls_sw_recvmsg
  __tcp_bpf_recvmsg [ bpf exec function called on encrypted message ]
  decrypt_skb_update
  decrypt_internal
  BPF_PROG_RUN on decrypted plain message - can we add this support ?
  skb_copy_datagram_msg [ decrypted message copied back to userspace ]

Thanks
