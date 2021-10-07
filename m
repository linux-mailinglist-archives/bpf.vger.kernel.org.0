Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FDC424C37
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 05:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239983AbhJGD3Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 23:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbhJGD3O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 23:29:14 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFD8C061746
        for <bpf@vger.kernel.org>; Wed,  6 Oct 2021 20:27:22 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so4001141pjb.3
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 20:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=jUwSNrbRqeZ2+wz9gNAx3uczGeWWOtNLeT0B6K0atA0=;
        b=VncFrraOl9IxkG17SsMh/+zZ2aouJNYYkkXNmfJe8vWXy8jr32xGn3drybta8yNGdy
         SRbqpvOIDto7NPYgXO51jGGenkbUtSzTQ/wvcbdLYq+ARdLGKWpXHUAXlVAvmioOZzzc
         r5Jk/9knT8yPBuTba3DfM9JUmU9hoF78El7z+ge7YaI4hxCcorQwV/1kj5khACgC5cKz
         uiVz6cUPjsm87+O9L9hDyMqXa57Rb++fVL1GAYCNjxpr/52u4MtiuAObfdYSfYALUijQ
         kKkLN1sY3kPNvwRO6yn0HOSMt4qKlwTqMOIcoELu7bqjw1DU+qtTSa9/kLODGu5a35bb
         JGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=jUwSNrbRqeZ2+wz9gNAx3uczGeWWOtNLeT0B6K0atA0=;
        b=2o80sfCcqLqT/wkvnKdNZ3QaiSnf67/UZfaRPnC0jLw//axwUQRQKtKiJIa5h+/UAC
         adWu25wPQ9UudSIDmcG6Fvzseb3tXjArcTx9c3MlHT1WkxlWyMP7PMgZBg96480sVa+I
         oLVVknHuJsVkkzb211dO0louKS5sjCJARBUuMRaduQxc4fwyeBhqG9NeqpzGTfQL0DE3
         LmM+hc7VFVYCLGthKpRZ/r80sEHOUZgMbjRA7PXAs7BcJ0X29KjfFFaKErU0MmYpqfhd
         whpcTAPYpRO399c+oQIEAnk9E6ivTGqAjbvk0ZcQA8CQRFIRy7ul12Qia44TfDpB9NZs
         /+Zw==
X-Gm-Message-State: AOAM532+fpRsbSAiTfgZ88SOrmOnL9oKojvlkGv24LS2y2j0503wJCRn
        hRjYa/C7n1MFx8Agh7S3HZuqs09dDqS39r7lPUc=
X-Google-Smtp-Source: ABdhPJwC+2ME4styyifBLf+aDUjWiZYmHMDEyEn3F0YFrRVn44H1rjb8C5VhcS/liMX9Hvsvy+9kOGy9rIPePj1WuYU=
X-Received: by 2002:a17:902:710c:b0:13d:f226:2e3b with SMTP id
 a12-20020a170902710c00b0013df2262e3bmr1510803pll.83.1633577241319; Wed, 06
 Oct 2021 20:27:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90b:3e84:0:0:0:0 with HTTP; Wed, 6 Oct 2021 20:27:20
 -0700 (PDT)
Reply-To: compaorekone34@gmail.com
From:   "kone.compaore" <abbttnb20@gmail.com>
Date:   Wed, 6 Oct 2021 20:27:20 -0700
Message-ID: <CAL4=2z=OJVFWejD7Bmzm=84xsk8T+RmtzbR9oa370mvtzDSgcw@mail.gmail.com>
Subject: Greetings from kone
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Greetings to you and your family.

My name is Mr. Kone Compaore, the auditing general with the bank,
Africa Develop bank (ADB) Ouagadougou, Burkina Faso, in West Africa. I
am contacting you to seek our honesty and sincere cooperation in
confidential manner to transfer the sum of 10.5 (Ten million five
hundred thousand Dollars) to your existing or new bank account.

This money belongs to one of our bank client, a Libyan oil exporter
who was working with the former Libyan government; I learn t that he
was killed by the revolutionary forces since October 2011. Our bank is
planning to transfer this entire fund into the government public
treasury as unclaimed fund if nobody comes to claim the money from our
bank after four years without account activities .

We did not know each other before, but due to the fact that the
deceased is a foreigner, the bank will welcome any claim from a
foreigner without any suspect, that is why I decided to look for
someone whim I can trust to come and claim the fund from our bank.

I will endorse your name in the deceased client file here in my office
which will indicate to that the deceased is your legal joint account
business partner or family member next of kin to the deceased and
officially the bank will transfer the fund to your bank account within
seven working days in accordance to our banking inheritance rules and
fund claim regulation.

I will share 40% for you and 60% for me after the fund is transferred
to your bank account, we need to act fast to complete this transaction
within seven days. I will come to your country to collect my share
after the fund is transferred to your bank account in your country. I
hope that you will not disappoint me after the fund is transferred to
your bank account in your country.

Waiting for your urgent response today
Yours sincerely
Kone Compaore
