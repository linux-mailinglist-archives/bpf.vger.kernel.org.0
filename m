Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CB11A6D29
	for <lists+bpf@lfdr.de>; Mon, 13 Apr 2020 22:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388296AbgDMUWW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Apr 2020 16:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388320AbgDMUWT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Apr 2020 16:22:19 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A1EC0A3BDC
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2020 13:22:19 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id y15so5817261vsm.5
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2020 13:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=untangle.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=ipQ8B5BCdKYWW1ngbujAdCSrZ/OvBl3zO2AZlQW5vjQ=;
        b=OPYxfAkymxfZV3vQ38WaKGOJP0zE6YbwMwVLSk8OMrnCSF1EuJs7QCXKByc1KysNM9
         BcSoNTe1kCRr+bABxII3jdHNP3yOyzm3kdWqOpdjWcac3LdB2+EerkY+a493dg2418rb
         blA6kbbnXoeWZr5MrQ/knS64VBGzFYW4kv2sA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ipQ8B5BCdKYWW1ngbujAdCSrZ/OvBl3zO2AZlQW5vjQ=;
        b=rudj6Iev4VMzdbNs798d7gYvZGFTa3Qy9V++tczcyNCLhWnG+nw4UKzDLCD9xDqfGh
         o9p1Wr/aYrl2XT2Vlq7sY45fjA3k2od9D2J+jdR7gMn/7KhDn2wRCqoPz2nyV5fiiuEL
         A+Y58WksCc5JT3kpoyDvfss8yqLmae5otFEDTozjcqVab1Cbial8fOPiE73tJw9eAlHU
         9dXLpS78Oo8kr/V5iduHTmChd1X82wuUozULkhhYK8lnVVPI58SQqhLXsI618F0hdhhP
         7NCQSHc+8FJNynv0Ydza4k+ndPw5phTDWog2Qsgg9zNUqThXs2MHdq/u0MFjMEvzrSdU
         jD+Q==
X-Gm-Message-State: AGi0PuYN0zHCCXlMQe8xRBeJBRnJ08Ht3NNWtLOWa0Ze2UxDlzQ/z+eO
        5IJFfOwyhsgnfhaES51daSUqJpS5R4XR9JGTP7o2LDfXhF0=
X-Google-Smtp-Source: APiQypIkis6EXX5mG0uWMRTr3+8OtkCSc5uNSd2A76Z7bUcQRejswUVlnA5fOLBz9mkYVzy/TvdczgwnKdAr80g4uiQ=
X-Received: by 2002:a67:fad9:: with SMTP id g25mr13498765vsq.49.1586809337654;
 Mon, 13 Apr 2020 13:22:17 -0700 (PDT)
MIME-Version: 1.0
From:   Tiffany Kalin <tkalin@untangle.com>
Date:   Mon, 13 Apr 2020 14:22:07 -0600
Message-ID: <CABkdAXa0y=fvAU63Wsk1b1rF1AHNraJrsRnyXfScELvqswc+OA@mail.gmail.com>
Subject: Bpfilter Installation
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I am interested in bpfilter and I wanted to play around with it. I
installed the latest Linux kernel (make && make modules_install &&
make install) with BPFILTER set to yes.
Following this video: https://www.youtube.com/watch?v=AfgwVya9Cog
I tried to run the bpfilter.ko, but it did not work. I could not do
modprobe nor insmod for bpfilter. Is there something I'm missing in
order to have bpfilter.ko run? Or is there a new way to run bpfilter?
Any guidance/help would be appreciated!

Thank you,
Kalin
