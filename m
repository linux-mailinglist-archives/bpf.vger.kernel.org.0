Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6CE9155E54
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2020 19:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgBGSnu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Feb 2020 13:43:50 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]:36133 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgBGSnt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Feb 2020 13:43:49 -0500
Received: by mail-lf1-f48.google.com with SMTP id f24so44994lfh.3
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2020 10:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=fYvCfKyPiCf/hdVwVs97IyhXrIhnGUFJXaGUhEhqUGk=;
        b=Gj3dWtcRbk//yY3rkE1aQYw3vqJBwiSFfmKHtowe2p/tvnwfPQjUm6daZQnVYufIUp
         f9Zh9qyYOGyq16IWdLXHPdt8+g4YcQgbhdP96GKRyRNiTDzmg5zw+xwhn7sBuLF68LI6
         uoGqQytHRKb2Zo4OL5HLTR1heG3AD7Ui694Txkb0rvOXKjDzyMvd5Ua1fTN5aaSqqoiY
         /B+ukJ6LAky2fuYqYNgfsyz9RV+wsxwnbpJ/t5xnJyD4HnhBeaaMPmkFaDoRaJD+47j8
         IA9DaPata6e5qEj58JDqCt2Y4M/WnyZF4P5hEIBW205vLbuSFZVfmYsUZ2oLRVIdKEKZ
         gMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=fYvCfKyPiCf/hdVwVs97IyhXrIhnGUFJXaGUhEhqUGk=;
        b=Htfx8qHVm8g1mPWnFdYU7Yn1n9MrzTUoXAhZ35ibltLggqH29TDpGXXU3tuaCB8a/G
         WbcPuV4arbHb2Y1lBjNMPwbpV2vpYBXUKqIUHZOiOwdK+eAKvXFcNWyqB3v/HpdHPvtr
         FskNmVBgi1+crLVmwoUnkqcqlYi36dL3qVYZ7hMBlbs6aYoWUsVm+OAZUnNmDzsGwD2c
         BmF7es2hOTfphPk6mEC6/XRnCeTSqyyUifzF99uWp0Y15QjdVM2pqIUUcNTy/TmDczd8
         GaOQYpVQPrWxqjfmSAWoJ2EC8jJQQM/E1u/OYyBgtOOLSAA53fUlKmnHbvEpFHOZLjbG
         OR+g==
X-Gm-Message-State: APjAAAUkCtLe4L1wo/DxDhu+mPZGT4mN0UAQhqSB8iZXkXmfoMwglh60
        es0cOEfltzzmyf723d/TmO04EGvBB7dJemL7yu7jo82o
X-Google-Smtp-Source: APXvYqxFAbBBSPwA25nNNoyWEwGAkkAQ8TlWZMNFfpdjUFnr9V/gjjBI+qQ6TFgMB9EhJgtzWr2o/Ss2gzpNHSzYehg=
X-Received: by 2002:a19:c3ce:: with SMTP id t197mr140043lff.174.1581101027245;
 Fri, 07 Feb 2020 10:43:47 -0800 (PST)
MIME-Version: 1.0
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 7 Feb 2020 10:43:36 -0800
Message-ID: <CAADnVQL7SiR-4HZnia+NiDFPW_JjhwaxrvgfPZBKQ91oVjcTwg@mail.gmail.com>
Subject: LSF/MM/BPF 2020 reminder
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi All,

A reminder that deadline to request attendance and
submit topic proposal for this year event in Palm Springs, CA
is Feb 15th.

Please fill in the attendee request form:
https://forms.gle/voWi1j9kDs13Lyqf9

The proposals should be sent to both
bpf@vger.kernel.org
lsf-pc@lists.linux-foundation.org

Please tag your email subject with [LSF/MM/BPF TOPIC] as described in:
https://lore.kernel.org/linux-fsdevel/20191122172502.vffyfxlqejthjib6@macbook-pro-91.dhcp.thefacebook.com/

Thanks!
