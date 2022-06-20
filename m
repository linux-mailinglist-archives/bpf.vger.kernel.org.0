Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3FD5521ED
	for <lists+bpf@lfdr.de>; Mon, 20 Jun 2022 18:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241968AbiFTQLt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 12:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241570AbiFTQLs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 12:11:48 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1ACCE205F2
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 09:11:48 -0700 (PDT)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
        by linux.microsoft.com (Postfix) with ESMTPSA id BF50820C3625
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 09:11:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BF50820C3625
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1655741507;
        bh=to0IRdIjbTG1vRQYgO1/jJVK6x2z6+DKgwcjwYN9oPY=;
        h=From:Date:Subject:To:From;
        b=HTuBlrWPh2emJScOSs+90zUYfsdVP+OJJh1ixB/kfVh71ADgVsysitoMXEZlrXU1Q
         xEGsFimx3k+TmC0D48Uaaz2KpOaZKqaMqydM+t+DLGdj3aX5KP6b59FTD0SElz0AH9
         U8r24lklvCb1Pg1cDh4VwuKgdRcPxyMfWqL5Ew+s=
Received: by mail-pg1-f179.google.com with SMTP id q140so10675908pgq.6
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 09:11:47 -0700 (PDT)
X-Gm-Message-State: AJIora9IJsm2C4x2Q5WYY7u6ONUo5kfrdQARXVV8NtGEMzP56fu33p6P
        Pby8EFHAtBI/komKDtizJvVukFTckZXn+8N/yjo=
X-Google-Smtp-Source: AGRyM1svc04INeNPJLwy73b9Z/UFL3gWs1rrRADascLrmr50z6fHx+OpkIbpPjkMeKn4GR7XpVeRv82YeSh2YawwX6c=
X-Received: by 2002:a63:2364:0:b0:3fd:a62d:4033 with SMTP id
 u36-20020a632364000000b003fda62d4033mr22350593pgm.20.1655741507390; Mon, 20
 Jun 2022 09:11:47 -0700 (PDT)
MIME-Version: 1.0
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Mon, 20 Jun 2022 18:11:11 +0200
X-Gmail-Original-Message-ID: <CAFnufp2KL-qNyDtWH5cNQ4DARqSQAygSi9GXgHD-iWs0XzJMcw@mail.gmail.com>
Message-ID: <CAFnufp2KL-qNyDtWH5cNQ4DARqSQAygSi9GXgHD-iWs0XzJMcw@mail.gmail.com>
Subject: scope id field in bpf_sock_addr
To:     Andrey Ignatov <rdna@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I wonder why struct bpf_sock_addr doesn't contain the sin6_scope_id as
in struct sockaddr_in6.
A program with type like BPF_PROG_TYPE_CGROUP_SOCK_ADDR might want to
access that field.

Regards,
-- 
per aspera ad upstream
