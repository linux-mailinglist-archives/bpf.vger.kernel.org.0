Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6031D2C401C
	for <lists+bpf@lfdr.de>; Wed, 25 Nov 2020 13:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgKYM2Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Nov 2020 07:28:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59658 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727114AbgKYM2Q (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 25 Nov 2020 07:28:16 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0APC39WV078944;
        Wed, 25 Nov 2020 07:28:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=AOYv5PLVg1KbAnnzqoZpxmfDX+3MkZZ45cURBdgIsTs=;
 b=X1q7v7DZFFJVYEjTqRpG+ZujOZNB28YlxGS4+EGJuPO6f6F1glMaMALWzK4zB6n4Zqho
 dX/3hsc/MHX/xU96Bj69IHzFRPtj+XCeYbpCRX2qWuwjms6G5dhp7V4f4BxKhrNtcDRr
 xl8SnmzKERqax3cX91qlGzGVgZVlFdGeZxZ9DHJ5q6n11qf+gbKG26sN+9xclzDFsMXH
 IJlkV6iSG3H7z0lWQQzstu/TwdgWvwSBo03Edm3b+vwcFW7owMUIyWmCTa1VmgKUPk51
 KTpnFdhr5K1YoqJP1fGKppGa3rK2qMEhyD1EY0+Kg2Y/EHajAHxmwaj3RB3BS9QeqLgb iw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 351nuuk7je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 07:28:00 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0APCPUBG011622;
        Wed, 25 Nov 2020 12:27:58 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3518j8gny2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 12:27:58 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0APCRu5G9175606
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Nov 2020 12:27:56 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 676C8A405B;
        Wed, 25 Nov 2020 12:27:56 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5664EA4040;
        Wed, 25 Nov 2020 12:27:54 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.81.213])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 25 Nov 2020 12:27:54 +0000 (GMT)
Message-ID: <260d493faed10725371d4e2ae4f39a780796aa57.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v3 1/3] ima: Implement ima_inode_hash
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     KP Singh <kpsingh@chromium.org>, James Morris <jmorris@namei.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Date:   Wed, 25 Nov 2020 07:27:53 -0500
In-Reply-To: <20201124151210.1081188-2-kpsingh@chromium.org>
References: <20201124151210.1081188-1-kpsingh@chromium.org>
         <20201124151210.1081188-2-kpsingh@chromium.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_07:2020-11-25,2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=759 clxscore=1015
 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011250075
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2020-11-24 at 15:12 +0000, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> This is in preparation to add a helper for BPF LSM programs to use
> IMA hashes when attached to LSM hooks. There are LSM hooks like
> inode_unlink which do not have a struct file * argument and cannot
> use the existing ima_file_hash API.
> 
> An inode based API is, therefore, useful in LSM based detections like an
> executable trying to delete itself which rely on the inode_unlink LSM
> hook.
> 
> Moreover, the ima_file_hash function does nothing with the struct file
> pointer apart from calling file_inode on it and converting it to an
> inode.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>


Acked-by: Mimi Zohar <zohar@linux.ibm.com>

