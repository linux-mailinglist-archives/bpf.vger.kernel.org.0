Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B78B17C493
	for <lists+bpf@lfdr.de>; Fri,  6 Mar 2020 18:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCFRiC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Mar 2020 12:38:02 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:56058 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725935AbgCFRiC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 6 Mar 2020 12:38:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id AEEB78EE11D;
        Fri,  6 Mar 2020 09:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583516281;
        bh=xEKu/eKkZNBH2WLwIN8gBntJSW3UGFxHLP7pWKKPyt0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=vZMnZaLngoVwWGLvZ5rKtsBWOfvxjWispu9XBK1SoqmkGe51plCQYvk5yEPP80Bxj
         BTNbO4Z4tW6NfMZePV/hXWvPDJnOz5qX8gNSFxv6XT3AXH+pdTbqYafkc0030ZnDU7
         EEhl2mSZXPvwOapRQWo9pUwYlEjtFbRlvsStx5M8=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Qy21NkEM44CE; Fri,  6 Mar 2020 09:38:01 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id CC04C8EE0F8;
        Fri,  6 Mar 2020 09:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583516281;
        bh=xEKu/eKkZNBH2WLwIN8gBntJSW3UGFxHLP7pWKKPyt0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=vZMnZaLngoVwWGLvZ5rKtsBWOfvxjWispu9XBK1SoqmkGe51plCQYvk5yEPP80Bxj
         BTNbO4Z4tW6NfMZePV/hXWvPDJnOz5qX8gNSFxv6XT3AXH+pdTbqYafkc0030ZnDU7
         EEhl2mSZXPvwOapRQWo9pUwYlEjtFbRlvsStx5M8=
Message-ID: <1583516279.3653.71.camel@HansenPartnership.com>
Subject: Re: [LSFMMBPF TOPIC] Killing LSFMMBPF
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     lsf-pc <lsf-pc@lists.linuxfoundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, bpf@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Date:   Fri, 06 Mar 2020 09:37:59 -0800
In-Reply-To: <20200306160548.GB25710@bombadil.infradead.org>
References: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
         <20200306160548.GB25710@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2020-03-06 at 08:05 -0800, Matthew Wilcox wrote:
[...]
> 2. Charge attendees $300 for a 3-day conference.  This seems to be
> the going rate (eg BSDCan, PGCon).  This allows the conference to be
> self-funding without sponsors, and any sponsorship can go towards
> evening events, food, travel bursaries, etc.

Can I just inject a dose of reality here:  The most costly thing is
Venue rental (which comes with a F&B minimum) and the continuous Tea
and Coffee.  Last year for Plumbers, the venue cost us $37k and the
breaks $132k (including a lunch buffet, which was a requirement of the
venue rental).  Given we had 500 attendees, that, alone is $340 per
head already.  Now we could cut out the continuous tea and coffee ...
and the espresso machines you all raved about last year cost us about
$7 per shot.  But it's not just this, it's also AV (microphones and
projectors) and recording, and fast internet access.  That all came to
about $100k last year (or an extra $200 per head).  So you can see,
running at the level Plumbers does you're already looking at $540 a
head, which, co-incidentally is close to our attendee fee.  To get to
$300 per head, you lot will have to give up something in addition to
the espresso machines, what is it to be?

James

