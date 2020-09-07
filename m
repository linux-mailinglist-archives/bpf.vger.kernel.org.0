Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67AF625FE03
	for <lists+bpf@lfdr.de>; Mon,  7 Sep 2020 18:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbgIGQFI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Sep 2020 12:05:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22845 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729985AbgIGOsC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 7 Sep 2020 10:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599490081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Hn1f0D3gK+jmS/twWbASzEx0oTYYOotgrflxJ+Qif70=;
        b=iD4rAhxzfhOm+tqW5dQzPqOqfoGvcaGpZ9HoEg3Ee4gSzYynHON4hCzbLa4F6rIhglRj0z
        hf/ykQV1c1ak4tKPflCQg7LtT6wqvwroTNo4HvWX35qt66bbUrETaN4DwAxTkOSbPnZbQl
        WeeIBdpcF6/xRJ5G4FsqZyZRXGGhDRI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-Wtj6T1NoNxO-KEnza1pFLw-1; Mon, 07 Sep 2020 10:39:14 -0400
X-MC-Unique: Wtj6T1NoNxO-KEnza1pFLw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2AF018C5201;
        Mon,  7 Sep 2020 14:39:13 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-127.ams2.redhat.com [10.36.112.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 128935C1BB;
        Mon,  7 Sep 2020 14:39:12 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Zi Shen Lim <zlim.lnx@gmail.com>
Cc:     bpf@vger.kernel.org
Subject: amr64 jit ctx.offset[-1] access
Date:   Mon, 07 Sep 2020 17:39:10 +0300
Message-ID: <xunypn6xd52p.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

I have a qustion about arm64 bpf jit implementation.

The problem I observe is "taken loop with back jump to 1st insn"
verifier test, the subprogram is:

BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1),
BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 1),
BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, -3),
BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
BPF_EXIT_INSN(),

Jitting the program causes invokation of bpf2a64_offset(-1, 2, ctx)
from
        jmp_offset = bpf2a64_offset(i + off, i, ctx);

which does ctx->offset[-1] then (and works by accident when it
returns 0).

As far as I see, the offset[] keeps actually offsets of the next
instruction:

		ret = build_insn(insn, ctx, extra_pass);
		if (ret > 0) {
			i++;
			if (ctx->image == NULL)
				ctx->offset[i] = ctx->idx;
			continue;
		}
		if (ctx->image == NULL)
			ctx->offset[i] = ctx->idx;


ctx->idx is updated by build_insn() already.

How is that supposed to work?

-- 
WBR,
Yauheni Kaliuta

