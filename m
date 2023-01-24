Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F2567A128
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 19:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbjAXS3b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 13:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbjAXS3a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 13:29:30 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8629848636
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 10:29:29 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id c124so3241086pfb.8
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 10:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m54Sqk02Mt1LMUdykxm/xF11P0SJ2vDzS7bOVluf730=;
        b=WCeN0VmtScrmUWy6amLb59x+eTidcur0PbzMHFB0/vsFlptB8lK9SdVD2oxtvVJfa+
         j5krf2fsjnMp/KMQEmj549KV+ADG4a6fGiR0TsyL8w5i2XA++4R9chb/1G0bTlVDe/6l
         p/stsGPXZslnAkZIJzLzysZw5tkMt7bsGPRfpy9LD7/c0fuNAi0JAZ5qTvwAaIRn7FHX
         OCo8sM6MQ9GK9wnJOPFMD0/dio4cuDgeojSoHdeHZ/xSNSZkHNnSVrQopZLJNKRd2TVT
         2PWoVU0X7/6EaJ9EW/2l5XE0z7xsKvXP+8KCq8Xqm0HQyF+cidgIekaPfSIGmLOJfDma
         bABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m54Sqk02Mt1LMUdykxm/xF11P0SJ2vDzS7bOVluf730=;
        b=Z33/ZfxcmwwsZqCjog864YiE7PAfRZ1dK8IuJqV5s63zJyIvQ55y0sLIfWxT+OAh0S
         zsq+m7XUZHpYn844suHsvMggWwVravYihL0WQFFoPGj/Ze8Ds57Ot8kUwEoOrle54yPA
         ExehdxZk+JMMqUp0iLbkjinbW1XuhD1Bevu9fFrkS9V64rnZWAdwT6leZ4IQc4/uedl4
         xvK890r8Z+QPxBXbBDx23IKGRC/muLI2AHif8EiL6D+j8r7NW1+Cc+Qa2Jn1jRcr7G4Z
         5aZqydR0xFqZ7sJ2YZBJ4IFMGUgLOzF5Ku+nY+NogQ0UrY/TCOBkaiz6BGWV3TrLd7Es
         t3Bw==
X-Gm-Message-State: AFqh2kq57e6GmrHMDEAJr4aG+3/jy15ZokK4HrKbCbEVvas7OILr6DLb
        E4dB7owCDArzKLXS2Kuw//bnvyGDleDeyIqWVjI=
X-Google-Smtp-Source: AMrXdXuuy612LOEGsVSI3HgHWfrmFF7BeAQLBvpcub6BjNoi9Hn2EfZXipyT7OMNjPfNEWQ0n5QF9TW6k+kj8jbS77I=
X-Received: by 2002:a63:234d:0:b0:4ce:ca5c:c472 with SMTP id
 u13-20020a63234d000000b004ceca5cc472mr2866754pgm.105.1674584968991; Tue, 24
 Jan 2023 10:29:28 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7300:b098:b0:97:d8a9:a406 with HTTP; Tue, 24 Jan 2023
 10:29:28 -0800 (PST)
Reply-To: fionahill.usa@outlook.com
From:   Fiona Hill <angelaemmanue@gmail.com>
Date:   Tue, 24 Jan 2023 10:29:28 -0800
Message-ID: <CAKpYVvC8kUaqm8sm4jtuCK9nM+8SyV6zZ_vR+tcy=BR38XhBcw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Hello, did you receive my message i send to you ?
