Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8300F561F7E
	for <lists+bpf@lfdr.de>; Thu, 30 Jun 2022 17:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiF3Plq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jun 2022 11:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235834AbiF3Plq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jun 2022 11:41:46 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEF33BBD6
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 08:41:45 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q9so27912164wrd.8
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 08:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject
         :content-transfer-encoding;
        bh=08P6bq7um69CgFJcK8RfFuaLGTo4ycgPn1AeuKP6N2s=;
        b=M6tzKji5SzZk8VSQVzIQs1KDUcvVMuJm5tQWhktko68AVm06Nv3H0pG+gZxCjQbzGR
         O252I43uUl6CpMcnszF7WW2l1zv0OF7hlf38kzUp81E9E3rcjESfjk/1LLytkbm+QlMD
         MoyDuTCjv4hc+M152hLnjuL5+03pNQXakxof+a0TfvzQlKeT3XutB2zy0a02yyKwsWa7
         8gnaPyrFnzRuOyBUd30OPCGB+VNGpzdqRh/EiViive2ei0uI0eltpOf8UDM3g1ciRm68
         fFOYvYwjmnHeSYYv7UMMUlyiFPPd4qd9ec1N04WYIODV56FoVtg2lP/rccLpdGlvJdCo
         koUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :content-transfer-encoding;
        bh=08P6bq7um69CgFJcK8RfFuaLGTo4ycgPn1AeuKP6N2s=;
        b=YFqanwxbm98+XFnsdZ6pE8RhqKSD6E+vY7c4efioRmgTE5I0vN+Iu8yv9zdk1aCGmE
         Z5A0pJTTgreAYhpx+0CSAoAH8fajepjE7OJ/Vb9zgnkdntKQmCIMCA9G9OpKT0HoW9gj
         9hgL1mB0OmOeGqqOE1+6vGBimxGakXafPCkYZ2uQnA67IYU/euQYNZTaE8y9BgZ9v8Sq
         tFL4jxrouhAVfsvfTd6nuXUCX1YtmlMwfa8BSnd6AChUkF4kqsk8sAptNcnt3JG4gfAp
         eld6Kv7rgpj9fFoVk9HHAuVRSx+9k21/eYr+LPvccLzUwWX7sENMQTZ9G8oNYuHj6eCz
         PInA==
X-Gm-Message-State: AJIora/1ptSazBPWSTvQSJrVOxBzBjtJRP2r3u1gb+SnuTSGHOEse9c2
        gVBF36JvtRpiQfcbjufDs1ygJ1pFeUQ=
X-Google-Smtp-Source: AGRyM1s/3u7dCkD2PsERePUxMXB2MS9ZetTXvrykOxNTQfO5qB5QIpHohiu5MQKOVaIqNicTTVE2Dw==
X-Received: by 2002:a05:6000:3cd:b0:21b:8e8d:470f with SMTP id b13-20020a05600003cd00b0021b8e8d470fmr8830300wrg.387.1656603703789;
        Thu, 30 Jun 2022 08:41:43 -0700 (PDT)
Received: from DESKTOP-L1U6HLH ([39.53.244.205])
        by smtp.gmail.com with ESMTPSA id t5-20020a1c4605000000b0039db31f6372sm3047996wma.2.2022.06.30.08.41.42
        for <bpf@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 30 Jun 2022 08:41:43 -0700 (PDT)
Message-ID: <62bdc437.1c69fb81.7ffb7.6d30@mx.google.com>
Date:   Thu, 30 Jun 2022 08:41:43 -0700 (PDT)
X-Google-Original-Date: 30 Jun 2022 11:41:45 -0400
MIME-Version: 1.0
From:   pride.dreamlandestimation@gmail.com
To:     bpf@vger.kernel.org
Subject: Estimating Services
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,=0D=0A=0D=0AWe provide estimation & quantities takeoff service=
s. We are providing 98-100 accuracy in our estimates and take-off=
s. Please tell us if you need any estimating services regarding y=
our projects.=0D=0A=0D=0ASend over the plans and mention the exac=
t scope of work and shortly we will get back with a proposal on w=
hich our charges and turnaround time will be mentioned=0D=0A=0D=0A=
You may ask for sample estimates and take-offs. Thanks.=0D=0A=0D=0A=
Kind Regards=0D=0APride Millard=0D=0ADreamland Estimation, LLC

