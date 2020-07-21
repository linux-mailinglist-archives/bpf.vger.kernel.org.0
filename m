Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E58C22880F
	for <lists+bpf@lfdr.de>; Tue, 21 Jul 2020 20:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgGUSRW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jul 2020 14:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgGUSRV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jul 2020 14:17:21 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C808C061794
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2020 11:17:21 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h22so25094491lji.9
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2020 11:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OvXKLLh8ZEA4bNc5W5wBd2XWeE7UBQm54dF3wDNQx0s=;
        b=sdoG/ruPz1XkQYes1Mql3PO5GHl7i51jIDIUJZqhmcVYpf2/3xx3k+UVtfxuXG4e0a
         FYZ3UjsED8W5I/S2NqwykVB1UxinHC+OImzmVlI/QnDT8dPf18UYoU2oMml6+RwmwmnR
         vhThyie2KpsfrQujiD9bPIKBCVpBoZggiKuCo8ggKDztkZzovO6p3u934HlZVFptAIeG
         VxOgzATg+4dGR3QUHl1X3uJ2BYqPY/0mSNxsTxSCLVsOSAw5gXlswuPPr+GiNvJ3j8sE
         u33Ekb9SJ1aZndWoretvGC9d65bQVyHLfyW9MCsexrSrvS4Gj0UBNod0kdzngb5SfP2u
         +tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OvXKLLh8ZEA4bNc5W5wBd2XWeE7UBQm54dF3wDNQx0s=;
        b=V4VTHDABxwaX/SaRmhN2btfzFo7o0xIa8Q/oYjJcP1Zae6rIfkY5JGxDFGmck5/CgF
         l3WSo+rp1jw7Y8YPhqlnID0EKumVCwzwBUsGrBpzuEZJHQsGSOofBKQda1nFcGNr3R0S
         V5Pb3/ZZVosxr6gYOy7CroWH99iBfzMfQPKfHDrPb1hX0L8dmUCd/QM153okZ6c4Xkbk
         b82bQ1LI4d1X9TTZDXWkUfWf3H6BmJKT6VAZFLaI4O+PY+9AftTzms9Elf9X+tcax1Sw
         XDo9WwGwJ9xzkUbriczZeOXGz9JxtZPdjh8HHKfCfZXJsHyqHi9RGGQ0zOz4nO9upCoU
         zwcQ==
X-Gm-Message-State: AOAM532T/Ba/XydBTyN+IoZzuxQN9Fsm3JOn1q+kLrYRj1y1NRn7p2jd
        ObetNcaWvbU9urPIxkO25HHymZvbVBIUASIjR8QDhQ==
X-Google-Smtp-Source: ABdhPJwYV7hlFAmXo6Ay3IYAO5QUh73D4VUi4AXAp+XJuC4AhM5ohBqRGTboie39zo6SoA+83DQ2JnW8If3E1xXjIeo=
X-Received: by 2002:a2e:9a4d:: with SMTP id k13mr14103673ljj.283.1595355439788;
 Tue, 21 Jul 2020 11:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200717165326.6786-1-iii@linux.ibm.com>
In-Reply-To: <20200717165326.6786-1-iii@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 21 Jul 2020 11:17:08 -0700
Message-ID: <CAADnVQKCdDD4DpQFCDvT5X3n1JSf3H6uzj27gyKacQ1bz+BCRw@mail.gmail.com>
Subject: Re: [PATCH 0/5] s390/bpf: fix lib/test_bpf.c failures
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 17, 2020 at 9:53 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> This patch series fixes three regressions caused by 4e9b4a6883dd
> ("s390/bpf: Use relative long branches") reported by Seth Forshee
> (patches 2-4) and adds two minor related improvements (patches 1
> and 5).

Applied. Thanks
