Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9FB57E5BD
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 19:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbiGVRj4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 13:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbiGVRjz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 13:39:55 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8D38EEF0
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 10:39:55 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r1-20020a05600c35c100b003a326685e7cso4898779wmq.1
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 10:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:content-language
         :from:subject:to:content-transfer-encoding;
        bh=/RZrB9rtBHsJejNK3YOAOGp+R6S9szlF4H1zijgKpQo=;
        b=QEACvtrIIOMQWuXVReNDLAjTQeVXjaAnbCghcPPeEgu7ZQ/1QewDWb6xM1jniqf1Tq
         h7HpDidO1xUwuCpRKYiSQQk9mjklCQspDjoTTW1kmyxh5n1dNgSmuXOGItDpIx7FHTm9
         sfVqVtGam/KpEXX+Vq34rvuCYjiigA/Fu2HkOauISOPdDIIr07hdYQce03TeeJU9+MQ+
         Rw95Ym+C/Dw1KRFvpVNQMp+AN3s9hdOEcB6Wz6cACOyTP0pP684FjIWLEutmbK0Fupi7
         w6kDc+ReSqUEL5v2b9zjCvT+D3+HfpSg+N1SXBx7hWO0rFivwixnx2XwLaIxB6gaNdlE
         S0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :content-language:from:subject:to:content-transfer-encoding;
        bh=/RZrB9rtBHsJejNK3YOAOGp+R6S9szlF4H1zijgKpQo=;
        b=fuhSldjcIQBtgF6Y4ZTpvO8g2lGnkN9FXyOEbixZ+MvExX5q8/lvjvmLrfm+4UqtSc
         jfidnWy4HL5bLRobTMQ1xQ0LzJOvPTIgav1n3lmAKbNzoe4qlVQEyOh0MgTWbNeye28j
         qxKIh4lnFbHo22ltO4wjdJ0275TlgfYen5AYOdWVX0XyikaB1UccXcA29jKre8x60H4d
         5bm7CYfjIkD+za3cYle9x9TPvcVDqXsLnOtWpn9Cubc5mbqaRwkKIy4SCvAT+rP+R6bj
         cgFWxWv1RT54hLmfBJFm6lxRYpdtKYb31eIg5mzwfORZr7k5ijI7B7NhWoe+OOXFApPB
         22eQ==
X-Gm-Message-State: AJIora9Chz6WnPreIp6xgtXlzTGxyVDCuQ8evJgiIFD2a0PfNLQogmtR
        Yc90BCp35UHLs4JTpMmITO8ztvPbGE9eDTO/
X-Google-Smtp-Source: AGRyM1u1vrpHnSTnMa0+CGeg6YVNWw3vrno02s0k8UvutgqGy/7voziBJW7GlIyDNcO+t6stTzG8Mg==
X-Received: by 2002:a7b:cbd1:0:b0:3a3:187a:296c with SMTP id n17-20020a7bcbd1000000b003a3187a296cmr13193996wmi.123.1658511593341;
        Fri, 22 Jul 2022 10:39:53 -0700 (PDT)
Received: from [192.168.0.140] ([41.216.203.214])
        by smtp.gmail.com with ESMTPSA id s23-20020a1cf217000000b003a2e2a2e294sm5747003wmc.18.2022.07.22.10.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 10:39:52 -0700 (PDT)
Message-ID: <c7d64fc3-62bb-e71a-c0cb-904476483465@gmail.com>
Date:   Fri, 22 Jul 2022 10:39:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Reply-To: halldnaendrew1@hotmail.com
Content-Language: en-US
From:   INFO <dawidcare02@gmail.com>
Subject: RE
To:     undisclosed-recipients:;
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: Yes, score=6.8 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNCLAIMED_MONEY,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:32b listed in]
        [list.dnswl.org]
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1559]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dawidcare02[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [dawidcare02[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [halldnaendrew1[at]hotmail.com]
        *  2.4 UNCLAIMED_MONEY BODY: People just leave money laying around
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

PLEASE contact Mr Andy for unclaimed funds  linked to your name

