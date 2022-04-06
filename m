Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34EB4F6E08
	for <lists+bpf@lfdr.de>; Thu,  7 Apr 2022 00:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbiDFWvb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 18:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237305AbiDFWva (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 18:51:30 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282531FF409
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 15:49:32 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236MNI7H035797;
        Wed, 6 Apr 2022 22:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=0ht4n+umdBaENc1g6LptveZ4AynK2fVrt3bj0lPFO+c=;
 b=TYgDVNxV9n2vA+oL75RV+KOA4IFVccetQUcZegOjYyQaERVsaUQUg6aufOpk5bFu5B4k
 9LY+2eGacO1c1U2dc6VNCMgBi9F7UWTstSKRQs3lPbG3OvUEH1jtfux7OoJuVmOI0eyJ
 /FH0LJejpkwE6aoG1XupezFXIRpa9aw4GwF9YthC6fx02D+7J/Eb/12QiAvicmTnU4l7
 zcDclXq8jbyQatqElIXiCyn5t0PstIvvrqDKJTw2N/v+GZW6HUdT5o6CPTtRdd3ZcvBy
 a+Rxm17kfVrVI97ajS10tcX4Eo9u0MYd8cZoMEUpsI9OoAL/hCexvtqbUiwH28Jn9+rb tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f9c1y278p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Apr 2022 22:49:11 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 236MeVjQ026634;
        Wed, 6 Apr 2022 22:49:10 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f9c1y2788-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Apr 2022 22:49:10 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 236MhK7u021926;
        Wed, 6 Apr 2022 22:49:08 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3f6e490hyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Apr 2022 22:49:08 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 236ManXj44302714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Apr 2022 22:36:49 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C996911C050;
        Wed,  6 Apr 2022 22:49:05 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EFFB11C04C;
        Wed,  6 Apr 2022 22:49:05 +0000 (GMT)
Received: from [9.171.82.41] (unknown [9.171.82.41])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 Apr 2022 22:49:05 +0000 (GMT)
Message-ID: <034e57e04eeb7dab4bad4fa674ab337a5534cbdc.camel@linux.ibm.com>
Subject: Re: [PATCH v3 bpf-next 5/7] libbpf: add x86-specific USDT arg spec
 parsing logic
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Date:   Thu, 07 Apr 2022 00:49:05 +0200
In-Reply-To: <CAEf4BzbETp3S4-HebGBNjFm1fCCAuytSqTp=SNXgXFSqsgCQOQ@mail.gmail.com>
References: <20220404234202.331384-1-andrii@kernel.org>
         <20220404234202.331384-6-andrii@kernel.org>
         <CAEf4BzbETp3S4-HebGBNjFm1fCCAuytSqTp=SNXgXFSqsgCQOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4XxGzKaZCA5H8iGD9IesPn70qNvrRNpn
X-Proofpoint-GUID: QuLS1BMV4NUlaPJRn-ilfdH54pz2SLei
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-06_13,2022-04-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 suspectscore=0
 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204060111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2022-04-06 at 10:23 -0700, Andrii Nakryiko wrote:
> On Mon, Apr 4, 2022 at 4:42 PM Andrii Nakryiko <andrii@kernel.org>
> wrote:
> > 
> > Add x86/x86_64-specific USDT argument specification parsing. Each
> > architecture will require their own logic, as all this is arch-
> > specific
> > assembly-based notation. Architectures that libbpf doesn't support
> > for
> > USDTs will pr_warn() with specific error and return -ENOTSUP.
> > 
> > We use sscanf() as a very powerful and easy to use string parser.
> > Those
> > spaces in sscanf's format string mean "skip any whitespaces", which
> > is
> > pretty nifty (and somewhat little known) feature.
> > 
> > All this was tested on little-endian architecture, so bit shifts
> > are
> > probably off on big-endian, which our CI will hopefully prove.
> > 
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > Reviewed-by: Dave Marchevsky <davemarchevsky@fb.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> 
> Ilya, would you be interested in implementing at least some limited
> support of USDT parameters for s390x? It would be good to have
> big-endian platform supported and tested. aarch64 would be nice as
> well, but I'm not sure who's the expert on that to help with.

Sure, I'll give it a try. I see there is some support in bcc, which I
can probably partially borrow.
