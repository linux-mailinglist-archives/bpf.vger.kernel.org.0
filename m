Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3434D40BB0C
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 00:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbhINWSS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 14 Sep 2021 18:18:18 -0400
Received: from mail1.arteliagroup.com ([86.65.33.73]:3935 "EHLO
        mail1.arteliagroup.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbhINWSR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 18:18:17 -0400
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Sep 2021 18:18:17 EDT
Authentication-Results: mail1.arteliagroup.com; spf=None smtp.pra=arnaud.bray@arteliagroup.com; spf=None smtp.mailfrom=arnaud.bray@arteliagroup.com
Received-SPF: None (mail1.arteliagroup.com: no sender
  authenticity information available from domain of
  arnaud.bray@arteliagroup.com) identity=pra;
  client-ip=172.21.0.8; receiver=mail1.arteliagroup.com;
  envelope-from="arnaud.bray@arteliagroup.com";
  x-sender="arnaud.bray@arteliagroup.com";
  x-conformance=sidf_compatible
Received-SPF: None (mail1.arteliagroup.com: no sender
  authenticity information available from domain of
  arnaud.bray@arteliagroup.com) identity=mailfrom;
  client-ip=172.21.0.8; receiver=mail1.arteliagroup.com;
  envelope-from="arnaud.bray@arteliagroup.com";
  x-sender="arnaud.bray@arteliagroup.com";
  x-conformance=sidf_compatible
IronPort-SDR: vZRb9cIVvUKAA5H/CtSHVTb/jJ182Dy8kJlKscMfuiNKlEYnvYibi4OgE4JHtxh5KwNOv2pA0D
 FCrez50nPkyg==
IronPort-Data: A9a23:zHZ0/anG5Sxf9zvw9F3BtX7o5gzxJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIXWzyOOKyNMTSkL913bdiypEIHvcfUndIxHVBo/yA9EH8b8sCt6fZ1jKvT04F+CuWZESqL1
 yiSAzX5BJhcokX0/39BCZC86ykhvU20buCkUreca3ktHVUMpBoJ0nqPpcZo2+aEvvDpW2thi
 fuqyyHuEAfNNwxcawr42IrfwP9bh8kejRtD1rAIiV+ni3eF/5UdJMp3yahctBIUSKEMdgKxb
 76rIL1UYgrkExkR5tONyt4Xc2UPS7/WewGUlndSWqGtmB9fvmo51aNT2Pg0MBgNzW/Q2Yg3m
 L2htrTpIestFqTWnu0AX19SCShvFaRc5LLDIHGwq8uO1wvNdH6EL/BGUBhmZtRAprcf7WZms
 KZwxCo2RhKElfC6wKCxYvdjjdY8JszueogYvxlIxivQDPlgSorERaTMzcFX1zgqgd1WW/3ZI
 dcaARJ0cB3LYjVRNVpRDp8i9M+innfXbTJVshSWqLAx7myVyxZ+uJDhPdDfe9GWTN9PtliXq
 2DB9SL+GB5yHNiTziWD/2OEmODBnDn2HokVEdWQ5+9lj1OC7nIcCBMWW1v9u+TRolW3Xtl3N
 UNR+ywl66M18SSDRd77QxSzvFaasRQHHcdLe8U45waKxq/d5S6HCWEeQjNHc5ogudNebWYp3
 0OSt83mCCZpvaHTT3+Bnp+PqDq2Pi4YBXENaDUCQBdD5dT/yKkohwjMT99LDqG4lNv4BXf2z
 izihCw5mLg7k8AU3Kz9+krI6xqnp57FXyYr6QvWRG/j5QR8DKahdoqu43DF4vtaKouFCF+Mo
 BAsl8WA7esDEYuAmQSTT+gXWrKk/fCINHvbm1EHN4Uh+jWr/Va9co1K5jxiYkFkLq4scjbzZ
 kLcuA55+pBeJn2ncelxbp7ZI9kxyKPIC9voTPbZcpxIb4QZSeMt1EmCfmbJgDqryhFqyedvU
 ap3uP2EVR4yYZmLBhLvLwvB+dfHBxzSB0uKLXw48/hj+bOEeHORSL4KKlyTdqYy66bsTMA5N
 TpAH5Pi9vicOdESpgHe65IeKVEDImI8GIiwoMtSHgJGzsyKB0l5Y8LsLWsdRrFY
IronPort-HdrOrdr: A9a23:SXg89akcyLklTeJW9jtM+9tojL7pDfI63DAbv31ZSRFFG/FxXq
 iV8MjzsiWYtN9xYhodcL+7WJVoLUm8yXcX2+Ms1NWZLWvbUQKTRelfBO3Zsl7d8kXFh4tgPM
 xbHJSWZuefMWRH
X-IronPort-AV: E=Sophos;i="5.85,292,1624312800"; 
   d="scan'208";a="41831049"
Received: from unknown (HELO mail.arteliagroup.com) ([172.21.0.8])
  by mail1.arteliagroup.com with ESMTP; 15 Sep 2021 00:09:47 +0200
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: Good news!!
To:     Recipients <arnaud.bray@arteliagroup.com>
From:   Brown Coleman <arnaud.bray@arteliagroup.com>
Date:   Wed, 15 Sep 2021 00:10:23 +0200
Reply-To: <abr23101@gmail.com>
Message-ID: <a799e68f-9c77-4305-a66c-bdc20d932549@SVPEXCH36502.arteliagroup.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello

Upon my research for honest person in your region produce your name. I am Brown Coleman, 17years old from Switzerland. I need your assistance to help manage my family's financial portfolio which was WILL to me by my late parents worth US$19,500,000.00 until I am eligible to handle property investments according to the laws. You will be paid 30% for your contributions.

If your answer is "YES" please contact me for more details.

Thanks.
Brown Coleman
