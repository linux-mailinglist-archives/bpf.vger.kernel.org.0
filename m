Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2386E18F9
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 02:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjDNA0X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 20:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjDNA0W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 20:26:22 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981BC468A
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 17:26:05 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id xd13so7730418ejb.4
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 17:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681431964; x=1684023964;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mcq9FXxqibiUDuuDF7zrSUoH+XaBEuj3iD3iDoZaVMo=;
        b=Ewr85AEmuFIcpqtbCJbfgmXg+kc8gNJCOpoQyMcptvzQ3+PbCiT7cDC4c71wrFnYuu
         z09ieQn8PiUjL7sbRuMnvgQFh5ejEedDH7/FmLLTn0cmg/qkcvzTWxfpi9OA1S8k0Rba
         hhWoTLCfYrek5N8AT0M1mt6ci+fx84Fd/2Bb0UjnK8uU7nrVKFCeWF0BKi81aMxf2ExS
         1Z8ECs7eUZombRJUo6qccztGmx47YN7MO5eNTaBQvuGBz9BrDRemj4ze/8psKKbhENly
         SDZ2dE8hM9IWsY74LHoNg6lpVgHFVedTMWdpsGxB7ZmcnPacoBfJrqpusVl5m6Q8QnT2
         BE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681431964; x=1684023964;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mcq9FXxqibiUDuuDF7zrSUoH+XaBEuj3iD3iDoZaVMo=;
        b=OaNO9xSHax3ZR3wBHSxR2Qqc8dkUZnug7Vw5u+Wf7/CRsvbyklEb5MKpnq6RW96Zr/
         GaA8iAPH43SFDNLLfY23UfrBo16GPWh+9Fd5YNHUPx6iwcKXI5Vw+Dmm9Nsb6ttG7mjy
         gLsVNYZ7JxmFhf9TK2WUSFPNpYoWbis7LGQqAulfNZMlAOudz5G5QkDvm3In6YKjAzmW
         xIpBucce5AqBT9Og3X1FHrDyxI3WgYDsdclh+R9GANxYsfRMpS8blqQSVN2j5I+NMsSf
         1ZfRTq6W720NUY4Md6vF35B4PgwZJsZgKEtV9P8UbMvgcfNUqzjsxECH+RFLYAurvt/Q
         AubQ==
X-Gm-Message-State: AAQBX9cXS/hkW0MfZCnk5vyyWviZtnUMJdRrRuKSUPM8gxEUtoST8uXB
        MpSB3aOyBrf4ZDPphK7ruSgqDyho7fVVsuhVpjQ=
X-Google-Smtp-Source: AKy350b1+w7yPqjTMXDYQIRbWECJHx81dZxL4Hqwqp/iQFtqEXHqInaxBS306SoijX0IQyRZCKXBCvbHXlmnyLZOoyo=
X-Received: by 2002:a17:906:3c3:b0:931:3a19:d835 with SMTP id
 c3-20020a17090603c300b009313a19d835mr2160296eja.3.1681431963678; Thu, 13 Apr
 2023 17:26:03 -0700 (PDT)
MIME-Version: 1.0
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 13 Apr 2023 17:25:52 -0700
Message-ID: <CAADnVQL53uhY7qwALpFWznTANbN0dnU=Pp-gZXUYT98tUBDtDQ@mail.gmail.com>
Subject: xdp_bonding/xdp_bonding_redirect_multi is failing
To:     Jussi Maki <joamaki@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Manu Bretelle <chantra@meta.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jussi,

after bpf-next -> net-next merge:

test_progs -t xdp_bonding/xdp_bonding_redirect_multi

is failing with:
test_xdp_bonding_redirect_multi:FAIL:expected packets on veth1_2
unexpected expected packets on veth1_2: actual 1 < expected 100
restore_root_netns:PASS:restore_root_netns 0 nsec
restore_root_netns:PASS:restore_root_netns 0 nsec
bonding_cleanup:PASS:delete bond1 0 nsec
bonding_cleanup:PASS:delete veth1_1 0 nsec
bonding_cleanup:PASS:delete veth1_2 0 nsec
bonding_cleanup:PASS:delete ns_dst 0 nsec
#326/8   xdp_bonding/xdp_bonding_redirect_multi:FAIL
#326     xdp_bonding:FAIL

please take a look.
