Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77785561B27
	for <lists+bpf@lfdr.de>; Thu, 30 Jun 2022 15:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbiF3NTo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jun 2022 09:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiF3NTk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jun 2022 09:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BE932D1D0
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 06:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656595178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=c6zIbiVwB8tcpo68NTBxxfwWW2l+v1QN557z7A8hUP0=;
        b=NqruPg9YVTbaL2YsyPci3iqyf1nbd+0sPGFPVhPRk+YQekd4nzlZG/us7+YHwFVAXy/sD7
        C3ncUGiemy3P3HnvY58r9smkfSeS7Vb07++YcBZMl7M4x947vZB4TmwOMBrxeYNKhnnPnJ
        iU5F9HaAeCyWdrBVksfjNKeWu7Qp0qQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-kD3oSxT_PDu4trXmPOYa2Q-1; Thu, 30 Jun 2022 09:19:37 -0400
X-MC-Unique: kD3oSxT_PDu4trXmPOYa2Q-1
Received: by mail-pj1-f70.google.com with SMTP id h11-20020a17090a130b00b001eca05382e7so1460527pja.9
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 06:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=c6zIbiVwB8tcpo68NTBxxfwWW2l+v1QN557z7A8hUP0=;
        b=A4h3ME8fqnKAp+mn+bb2DmsexHPAIj0xVxWRiWxv+oEoyJKsxb+gJVU2Mn3ScqEBHS
         s8PkW7UQoy+1CImR/r3joDSMIRMu8EKRP83dfTPqLC26xF81gvHwi6knQxCMgfqYdTj4
         gGMaY7ZmAcI/E7w5HDtZMnBKm9cfGc6zHV/FQRYiKL3NV1MJsuYw6Q3K/6neqXEj15Je
         qkgmRKuGebzanjsYZFdwPu/hAq+o+sWZwD1uOL5SCclUE4Fl4OvLoaXO4UowjXZ0xIEy
         2f0kj2vykt8cRzjhP1xakkUa4RSvh65QOe2vVzX4xmPq7eyFgWlavh9dvAbQE4n0IUt9
         gd3w==
X-Gm-Message-State: AJIora/ISy+qP90J+nwLU0afp7gi7iGH+0rzENpkHpHQNeR9Tiayw4r6
        v1j7h9DxgycVwoEnObQ2OT5bY8ttNb3mZMs/jRdOTQuLIbb9F2RPr1dXhGUxfXNM980HQdJV5c8
        0EELSKN9lttnRdOGmmdfLoAGS2m1h
X-Received: by 2002:a17:903:44b:b0:16a:1aba:9f80 with SMTP id iw11-20020a170903044b00b0016a1aba9f80mr15734386plb.56.1656595175878;
        Thu, 30 Jun 2022 06:19:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tgP8P/GnvCg/ijMSQrDb7orrzm28dVco5athKGjKgC0A2Bi5yETktr3fZoAlY4FZuhQWBGKt5O8uXR1tvL56k=
X-Received: by 2002:a17:903:44b:b0:16a:1aba:9f80 with SMTP id
 iw11-20020a170903044b00b0016a1aba9f80mr15734367plb.56.1656595175599; Thu, 30
 Jun 2022 06:19:35 -0700 (PDT)
MIME-Version: 1.0
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
Date:   Thu, 30 Jun 2022 16:19:19 +0300
Message-ID: <CANoWsw=eP+kYHvT+AUwY=8D=QDrwHz=1_6he8vz0t+Tc1PVVBQ@mail.gmail.com>
Subject: test_kmod.sh fails with constant blinding
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

test_kmod.sh fails for hardened 2 check with

 test_bpf: #964 Staggered jumps: JMP_JA FAIL to select_runtime err=-524

(-ERANGE during constant blinding)

Did I miss something?

-- 
WBR, Yauheni

