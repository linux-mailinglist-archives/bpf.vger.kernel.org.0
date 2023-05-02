Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66056F3B28
	for <lists+bpf@lfdr.de>; Tue,  2 May 2023 02:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjEBABu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 20:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjEBABq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 20:01:46 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3C23A86
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 17:01:44 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4edc114c716so3795414e87.1
        for <bpf@vger.kernel.org>; Mon, 01 May 2023 17:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682985703; x=1685577703;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jY7mvudCnbkk/wPy6EaNjbub97+6maXL98u0YeQiCec=;
        b=MgavJzoxomc02x/jkI46agrAFcLc1aI4ON+ykweW+fgReAFiuOQ60q5Q6NLtN3dolL
         FgDg+9+rgnLv6GohcZdwUfzq93F6GvgHiqsbPYpDOaLzYrnc8z6LU3gplkljOKT8IjXN
         ptrdOQVBZr5QGuSiwVYRF9ihr5NBZlv171rMxe0i5It/J7i8ZwOiSmbCA8HoNfcQPm5b
         f6QlUwjdYntRAZABLC3ekGqZylqs423Sv8y5UV1IaF4QPQ9v5WzNdhenVZsd1wvEdKcy
         MaF8/TR7XPHr8UdKwPRNA3JCye/L6uExz5RqLebclEmaZqiWRhZO2EAjzvjRpt5dYAJd
         /bkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682985703; x=1685577703;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jY7mvudCnbkk/wPy6EaNjbub97+6maXL98u0YeQiCec=;
        b=caUbvZwqF9Qw6iHz54dVt31SkMnvs1KQGHozL3fkH+nUTAW1EQxMe7jHlKnlHMWxFw
         ypXZOVWxmMA/yrwrkd/hFlxINmoIAzA6Bd1wPY3lsjnPoOP8av0h2Wl8aFX1Lg8yVfl4
         v3anZdH6iLtyBcr4qhQKVZcxZMmhxKIejFruErn0uO6T+TfvJOdBmdoC3Ap5aVHx05Ew
         CsVrMHTBj+N9tsc8e6NHJ+pG1WnlgU2juY0Lld63HfPNj7+DJMW3+A7xHklQA/dSE7C+
         sYrNlyj023WBPSiCE2KlqeC0LBvaugoEaMxnn27jNJpilaDaW2R3MFM6p5wpA8DJQBDp
         TdNA==
X-Gm-Message-State: AC+VfDwowSKGowc+5he1kPOQnplir1kDiKhpt2oeAlvUl79S/IT6rq3X
        3upQciBKUEd7xTLi4CCm8GKgagx+m4AZt4yw0Cc=
X-Google-Smtp-Source: ACHHUZ6WwwQusyzPOmiYEq9u2+CBPYHJKkXyibXjUMRHQ5PqfSI3SnyWxP3bJFcGS8mMHTZbSMCfOCSNtt8geytJx6A=
X-Received: by 2002:ac2:5e91:0:b0:4ee:d4bd:3475 with SMTP id
 b17-20020ac25e91000000b004eed4bd3475mr3478319lfq.32.1682985702471; Mon, 01
 May 2023 17:01:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:420c:b0:258:2ca7:e3ca with HTTP; Mon, 1 May 2023
 17:01:41 -0700 (PDT)
Reply-To: cristdaviis@gmail.com
From:   Cristy <gtab92432@gmail.com>
Date:   Tue, 2 May 2023 03:01:41 +0300
Message-ID: <CAKPd4E-aMkRu_LWzLDxqjmXHdF9pGDtiFLcDBMRvNHnOBopncw@mail.gmail.com>
Subject: RE
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Hello? Did you receive the email I sent you?
