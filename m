Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A639633EF98
	for <lists+bpf@lfdr.de>; Wed, 17 Mar 2021 12:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhCQLab (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Mar 2021 07:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbhCQLaC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Mar 2021 07:30:02 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C9AC06174A
        for <bpf@vger.kernel.org>; Wed, 17 Mar 2021 04:29:50 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id v192so33847952oia.5
        for <bpf@vger.kernel.org>; Wed, 17 Mar 2021 04:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=T+yfoiKirACOFePrDhMk6aYorx+MUMEYXexIYS6ltN0=;
        b=fw25e0sktxU3L87x7F+T07wt9bn14HMWAVt+coacEBQzx9CfbZTr7J9/pVDqZXdvnx
         SukKXhHyAhm9tyNXgGsmjlspNikPylCImCaloGS4EYXHayybLd6finb6hUuDUGvOeDLQ
         jAUtvPgraheKIqHI0wfb/eMT739J9tfI+B2FxrUi5rTHxMvBJpWXFySnaogWgEBM7xNu
         C8bR6sDpgtYFS8VCHhyGRJW+fiMZVO4xmzQGvwhu1Dofgvgkvqmvu9Ip7gUa5oLl4GLV
         eymCilIih05QVDvwCZXta+LkfdOyDLiwvnuPR1ge3ja57tUhY3WZHnGxr+B/S+hnKGMI
         hlag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=T+yfoiKirACOFePrDhMk6aYorx+MUMEYXexIYS6ltN0=;
        b=QBO2dTDrhRADC7oLwDcx8HyM3Y098SK5cmJrr0G7eQqEzYnLVbXY2DSQ1I8P+wniu1
         uF/nVzEChGrP8kNYzlqTKVPcwoqzdl94OMQxeKxIxEAAFy3v1bOWqYoCTyOouppgrFTe
         FNVV9H11R8N5O6b00Y60DBIqS2uSccHEIQNO9SWyUVc3eTkOARV2ovhkTS34SvZ285PE
         rfKssn/rcG36QtRZk3zABhfAWD4rRZnWJUl37x+dkDg89KUmgFX+6o8ykecpRPSu4AAl
         sBz1ginvol15S3bLWXM/geov+RaW9Sue5XtHdrVRJE06Cnx4L0e0U45ktpi3qwobtzQb
         /IFw==
X-Gm-Message-State: AOAM530//kJlbl1WezmCg5+YzmWHbmIXM/kFsZkskWSIdNk3rUI5Aizs
        2XfR+QxbqWTbtYe6RW2ue+ii5KVAs0Is/CBZv2U=
X-Google-Smtp-Source: ABdhPJyaGMy2T2w5txN+ORL3S8Mia7ckLqZ1FF/OOhTV7yUDjhfl8vWsvZVrhGcdfZzJinZU8pfaJUg7+cRAHw//Ogk=
X-Received: by 2002:a05:6808:904:: with SMTP id w4mr2374598oih.1.1615980590496;
 Wed, 17 Mar 2021 04:29:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:a5c6:0:0:0:0:0 with HTTP; Wed, 17 Mar 2021 04:29:50
 -0700 (PDT)
Reply-To: georgemike7031@gmail.com
From:   george mike <fiacregnansa@gmail.com>
Date:   Wed, 17 Mar 2021 12:29:50 +0100
Message-ID: <CANUG119J9ThdLq6kUGUDKMY8+krrscUb4LuhM_Uu2JYV2qJE0w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

0JfQtNGA0LDQstC+DQoNCtCX0L7QstC10Lwg0YHQtSDQk9C10L7RgNCz0LUg0JzQuNC60LUsINC/
0L4g0LfQsNC90LjQvNCw0ZrRgyDRgdCw0Lwg0L/RgNCw0LLQvdC40LouINCW0LXQu9C40Lwg0LTQ
sCDQstCw0Lwg0L/QvtC90YPQtNC40LwNCtC90LDRmNCx0LvQuNC20Lgg0YHRgNC+0LTQvdC40Log
0LzQvtCzINC60LvQuNGY0LXQvdGC0LAuINCd0LDRgdC70LXQtNC40ZvQtdGC0LUg0YHRg9C80YMg
0L7QtCAoOCw1INC80LjQu9C40L7QvdCwINC00L7Qu9Cw0YDQsCkNCtC00L7Qu9Cw0YDQsCDQutC+
0ZjQtSDRmNC1INC80L7RmCDQutC70LjRmNC10L3RgiDQvtGB0YLQsNCy0LjQviDRgyDQsdCw0L3R
htC4INC/0YDQtSDRgdCy0L7RmNC1INGB0LzRgNGC0LguDQoNCtCc0L7RmCDQutC70LjRmNC10L3R
giDRmNC1INC00YDQttCw0LLRmdCw0L3QuNC9INCy0LDRiNC1INC30LXQvNGZ0LUg0LrQvtGY0Lgg
0ZjQtSDQv9C+0LPQuNC90YPQviDRgyDQsNGD0YLQvtC80L7QsdC40LvRgdC60L7RmA0K0L3QtdGB
0YDQtdGb0Lgg0YHQsCDRgdGD0L/RgNGD0LPQvtC8DQrQuCDRmNC10LTQuNC90Lgg0YHQuNC9LiDQ
iNCwINGb0YMg0LjQvNCw0YLQuCDQv9GA0LDQstC+INGB0LAgNTAlINGD0LrRg9C/0L3QvtCzINGE
0L7QvdC00LAsINC00L7QuiDRm9C1IDUwJSDQuNC80LDRgtC4DQrQsdGD0LTQuCDQt9CwINGC0LXQ
sdC1Lg0K0JzQvtC70LjQvNC+INCy0LDRgSDQtNCwINC60L7QvdGC0LDQutGC0LjRgNCw0YLQtSDQ
vNC+0Zgg0L/RgNC40LLQsNGC0L3QuCDQuNC80LXRmNC7INC+0LLQtNC1INC30LAg0LLQuNGI0LUg
0LTQtdGC0LDRmdCwOg0K0LPQtdC+0YDQs9C10LzQuNC60LU3MDMxQNCz0LzQsNC40Lsu0YbQvtC8
DQoNCtCc0L3QvtCz0L4g0YXQstCw0LvQsCDRg9C90LDQv9GA0LXQtCwNCtCT0L7RgdC/0L7QtNC4
0L0g0JPQtdC+0YDQs9C1INCc0LjQutC1LA0K
