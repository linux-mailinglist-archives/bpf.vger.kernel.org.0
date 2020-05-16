Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0DA1D6435
	for <lists+bpf@lfdr.de>; Sat, 16 May 2020 23:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgEPVWK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 16 May 2020 17:22:10 -0400
Received: from sonic313-9.consmr.mail.ne1.yahoo.com ([66.163.185.32]:44280
        "EHLO sonic313-9.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726592AbgEPVWK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 16 May 2020 17:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589664129; bh=5gCyJ+OqEpp5mbAlNtNv58P62XCklDNCTlGARRHXZQA=; h=Date:From:Reply-To:Subject:References:From:Subject; b=MweTQfsQSaTZR1vDS+xOZRrT5RibpeQuLtnaPT44hU8Ig6hQZAUbPKb7g1ZFx/wfNeq4Bm5cCeLEAfZiZ2S6nS40A6AG7MgB83M9MNq5VMv+Xodn60OIuoOBcaIR8mIIc7u3e4gTBXkfpcGARCxIO+04KnPs246N0spnUCKUP8RvZjZutOZjTr5y2fr89giPv7mfso6blYEPVUT8oXVtH0pb6hJ2BZb2qe2I+rZMuROqtrJdba1KnTqUtxDZfXtVLMSCTvarB2A9afYYJ4LyQIPqDKV4aQA4BCzPjcyw3X3BLVWZ0dSZWinA9eXL26MQhy7bPXYVdEU388nrobv3qQ==
X-YMail-OSG: myttoUwVM1mW8Sn6CKHPlTxD6raPBi4PLonqfjIE_hWnUamqEhiFdQE_4rKCZVA
 cXnmjmeuuF8jqYfGKRpcfQbzJMDu_RynQQqlRPzIjyD014soAIKTPHLP1gG0mGbGp1.kKbp1fGxs
 b3MFx0vHnli1kkKYFvRE8fBwsKYFlDIIyestBja5fgyv0CrMmouyVz_DspXbJrmJaJzZdHEcnq6Z
 LJDE0H6EKC.W9NYKoxRGM613i0HV8KYtE616uHhfOGTW1HVpsZJBxES3UB5MYj1R02hXiLifIeST
 U9HRuuL2P44dCms1tp0uQ9ppqZZzjjhIUN.vDM9nPP4YrqXP4aNIRR3bHlmXA70pwcsmbbSHXvBX
 owRjedzwhQCnjK5oC3jAo4_3ZUXpElnSDNfMrcFCUn9nmXK4psRsm7eOfOHUlle_pfXjgYJw0MNq
 2qEC5z2AwFHamOHjtdUcbXZ7YeAEIRKhwGZGq284LrGP2hW3VxIIUYZYpkrNtSowdgHHiBDyKn3i
 t1buqFB3KmB1Y3sU296WhGy1ougfEQJcywMa3595ASpUWN8Sl.7ufAF_i9EPLm4PQzHEmx4fvH3j
 MFv7Twq4b.Y3aR9eEjtAri6jImd9NWKb37ynTSKOGwdiE9VMNcyWGY0T.WuvpprjhDpyG6SJA4r6
 aoEfV4kMQdpLLhBfjtC8IAep9otA_rQyOyO2NwYUGD5stANLo.7vviomIsnvEoE_cgTyUBPEpPak
 GJS7cHLNS9pCrTZoodDjbr9.fYNO6ZwwhA.pLUn3ANPzs91PUl1x3JcUj8BUA8kFSWXZHXyX2O.7
 m4UMtxqTLhXo7AUUjzqz5_Nz.MtMzBXfg2ED.kRi.onyEJ19KOc4MFmV_f.cvzQXHl.jSGMrRrq4
 eQvi1rWs9RBz7Vbq_zKudMWnKz8fdWEo1SrJZItZW66NIH8g6GfVBmQ8KjLI6BbhRLe5iDCQpRLF
 7MKFSD8ROsal5FayBou4ABsdiEzwArDx3P1UDCEt5erVTOX.1EXZBExCUqbIbTQcTggMqfY930Je
 L08NOHRtoH_pX4f.QX1R0BBnTH8JYHJNRN2VNA506xZ8xZXHmVlh3gFOTKvK6MchZcPBa3P0t4r7
 oV4tGob_y8Isp0RlKTgJldBjlh1y90qVFKZjhvbMrJChWz.qRiXPBak7xq9u0NrL_zW9mOi5EaeD
 KzPk2r_Ki5uMqc3YrSIhZcRMHK0yVD8pqsb.ApnH0HWVIJKLDlOKDj3GJlvbM6afaZFKxfQJyfVR
 4dgkxJ__EHJW64QbDcv3NoMA99FOpqJsrEMOxNmdIMQSqLR_e8zmVkph3QKaHZ_6OBkilT6Hc2JC
 qb_21nQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Sat, 16 May 2020 21:22:09 +0000
Date:   Sat, 16 May 2020 21:22:09 +0000 (UTC)
From:   Rose Gordon <rosegordonor@gmail.com>
Reply-To: rosegordonor@gmail.com
Message-ID: <395866934.236010.1589664129542@mail.yahoo.com>
Subject:  Hi there
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <395866934.236010.1589664129542.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15960 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:72.0) Gecko/20100101 Firefox/72.0
To:     unlisted-recipients:; (no To-header on input)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Best of the day to you I'm Rose by name 32years old single lady, Can we be friends? born and raised in London in United Kingdom Take care Rose.
