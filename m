Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24863B7755
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 19:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbhF2Rk2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 13:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbhF2Rk0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Jun 2021 13:40:26 -0400
Received: from mail-vs1-xe61.google.com (mail-vs1-xe61.google.com [IPv6:2607:f8b0:4864:20::e61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDAEC061760
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 10:37:58 -0700 (PDT)
Received: by mail-vs1-xe61.google.com with SMTP id 68so15110vsu.6
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 10:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:dkim-signature:mime-version:from:date:message-id
         :subject:to:cc;
        bh=zthhZ9jdCXIWdOsZ/wYauwpGG80Lj4IedY8vX/qxgyo=;
        b=cptEcPXG86xbKun12L+xSHwYkobUK1CviP5r52lTpRJYxvQuU7iiF63iPDZilNAiwe
         GShGgYua1Xhhk3q1pux/Jd3EyT6VdZIHlk3ypX7BNBLLO/IJTVvDrfDVJTmyBP2zJdss
         C3aDQqnHGSlHcnCrw959Wt74PxGIyPvudYQTzoUSYShDi8xIaCDMsP5SOwocr5xX1cN3
         KZw3vlCsEH78aT44QRmkut9IqJbeHt1DTlqz2OWtMg8e8cqzbqgCIauVqWJHFMBJ9yGz
         iWLAyunQvEmt0bJPTiN3e3pQ7DppB6XzOO4KcakEKYN8wSI98oFPW5EoglCrcvApVI71
         AfCg==
X-Gm-Message-State: AOAM530lQepY78g4m+DbgujTq7mhgGYN046IxL0krY2exf8qezdNlTTm
        WC5jL2jpBqk/J1jsXWofH1nUYHxeMfAlctxQFYQT39ysq+Qsyw==
X-Google-Smtp-Source: ABdhPJxMMe2g6hNAIgN3043CcY1c/EhjTSDmV51Ic1Ukz81ou/2zMlX3jY+qIeQW8Kchou0GXaJb0aVqyZMQ
X-Received: by 2002:a67:c39c:: with SMTP id s28mr25973895vsj.44.1624988277752;
        Tue, 29 Jun 2021 10:37:57 -0700 (PDT)
Received: from restore.menlosecurity.com ([13.56.32.62])
        by smtp-relay.gmail.com with ESMTPS id l7sm330651uar.2.2021.06.29.10.37.57
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jun 2021 10:37:57 -0700 (PDT)
X-Relaying-Domain: menlosecurity.com
Received: from safemail-prod-02790022cr-re.menlosecurity.com (13.56.32.63)
    by restore.menlosecurity.com (13.56.32.62)
    with SMTP id bd35a910-d900-11eb-91b5-b3c80c742345;
    Tue, 29 Jun 2021 17:37:57 GMT
Received: from mail-ej1-f69.google.com (209.85.218.69)
    by safemail-prod-02790022cr-re.menlosecurity.com (13.56.32.63)
    with SMTP id bd35a910-d900-11eb-91b5-b3c80c742345;
    Tue, 29 Jun 2021 17:37:57 GMT
Received: by mail-ej1-f69.google.com with SMTP id g18-20020a1709063952b02904c6c7b11c45so1450071eje.2
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 10:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=menlosecurity.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zthhZ9jdCXIWdOsZ/wYauwpGG80Lj4IedY8vX/qxgyo=;
        b=HhAnHgG/v1tnXdqjyPbp+Py0jQTqL2PhPAbPxnvG7dGji0OoRfgEt8AcirWxAP3fqR
         Z3gbkTl1HjthrHvRbEz2C3CG7LCCeCs1RL4LKc1Q3yBn3LBlLaTdBSZGypgkU9+uS0bm
         9YSDCqZoWEtJT7n0QBEd5eXwtV0eODsV2YKNA=
X-Received: by 2002:a17:906:9e05:: with SMTP id fp5mr23447787ejc.376.1624988274313;
        Tue, 29 Jun 2021 10:37:54 -0700 (PDT)
X-Received: by 2002:a17:906:9e05:: with SMTP id fp5mr23447782ejc.376.1624988274163;
 Tue, 29 Jun 2021 10:37:54 -0700 (PDT)
MIME-Version: 1.0
From:   Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Date:   Tue, 29 Jun 2021 10:37:43 -0700
Message-ID: <CA+FoirAefuGFbDVBenv1zh5PeR9V3JS=k8o+01zC7ytEs9g+8g@mail.gmail.com>
Subject: [PATCH 2/3] tools: Update bpf header
To:     bpf@vger.kernel.org
Cc:     David Ahern <dsahern@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update bpf header under tools to bring in the bpf_fib_lookup
struct changes.

Signed-off-by: Rumen Telbizov <telbizov@gmail.com>
---
 tools/include/uapi/linux/bpf.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ec6d85a81744..6c78cc9c3c75 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5925,8 +5925,20 @@ struct bpf_fib_lookup {
  /* output */
  __be16 h_vlan_proto;
  __be16 h_vlan_TCI;
- __u8 smac[6];     /* ETH_ALEN */
- __u8 dmac[6];     /* ETH_ALEN */
+
+ union {
+ /* input */
+ struct {
+ __u32 mark;   /* fwmark for policy routing */
+ /* 2 4-byte holes for input */
+ };
+
+ /* output: source and dest mac */
+ struct {
+ __u8 smac[6]; /* ETH_ALEN */
+ __u8 dmac[6]; /* ETH_ALEN */
+ };
+ };
 };

 struct bpf_redir_neigh {
--
2.30.1 (Apple Git-130)
