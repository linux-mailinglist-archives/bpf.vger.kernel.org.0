Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48DE2BBD8C
	for <lists+bpf@lfdr.de>; Sat, 21 Nov 2020 07:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgKUGtL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 21 Nov 2020 01:49:11 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32690 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725934AbgKUGtL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 21 Nov 2020 01:49:11 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AL6eX8f031512;
        Fri, 20 Nov 2020 22:48:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=SZWzAAHIKlhGjusu9w712VC+tK9eIJr9lSNYGZwCT8Q=;
 b=EpWXnQXSnSlUriVqST87PM2oP9UH5wmwWW2yYBqLK8c1kNxmevi85o+ZMXwZr8MNshaK
 e8VWvFoh3RVxQoM3RidkCI6yWHMS5x3ZzEgpBCrzwwZEj0pog9RXhFjLqRXZMz9OG02D
 eFfHsipdTD771Ik360bnpzp3YGOILFY3PVI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34x5qxxu4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 20 Nov 2020 22:48:54 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 20 Nov 2020 22:48:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABoo9itfYWqYK8hkK9B9xBlnG+lNtGdRr0aU8iD/qEWMmIRLnAd3FETil5zTxwVnpEhFonyswmcXye7sDYhppGEqOTuHOSfADzjQsLX+Z5KHSEZQ+irbgGoRaSapeD8fE7ljt+d750Wiiyf1h2Gc9ZWS5POkIX3rC3tREVS67qf+iy2XpFpSu45nbHP5OSTA5E/HrlOiNbv7Lnhc85BVwQiAnNrhU6P3VgU3Sd+60wLcWBNFW/dCqxduoeE1nCB/f6fc+sB6qo4kxXnPUQWkn3DLvjjDRqPmmq8qUP8N4hnHHcjBKUHv7T4Y4HhitGXtUQAxYiI56Hs/O3k9QQY2Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZWzAAHIKlhGjusu9w712VC+tK9eIJr9lSNYGZwCT8Q=;
 b=S5k7uRbf0a2kMkTEEasDZ36WBFTp3jbm9nHKL6qtkOTEa84qfCrQb21SPTyDStChlXH7abjg9FyWVRM9VuDmqvXtOgT1HHHYvm3Yoq7a8P7GTMvkCIa+XQ93q/dwgSxDcKr7rUPu+/68QSj/0yXnzZtOZgj8mt6DeIOuy3+gm4FJTe5C3f+LEe1pDUC/f/VAFfRdM7dDZwxtPYiuvBQRnpB2JojSYu9a7DORTD0IGgn5CkgaYOHzKulzRv1OOpLxwL/IUIWFZVL1js4uVuvKQJ4+CKXdN1b/e86WAiw/qNmdS7tl7TGGhZNPDGbsXZjv67TQIoRSghI6AmdBKA4G6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZWzAAHIKlhGjusu9w712VC+tK9eIJr9lSNYGZwCT8Q=;
 b=bkz0c2CV08OztpVYM2kIFGOxCveeLeKOUZYZN0FzdHCvFxYT9iaWRX8DY1KKterpsGpXLRI7RFTiMLQx9/FUmGXjOnfvHADmaAYeuapw99ADno+Ao+sPxYqYi6KT/7iZJHTu8vYcf5oROM0RcPmXaIUBnO4uBr+IQtzPBFketvM=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by SJ0PR15MB4204.namprd15.prod.outlook.com (2603:10b6:a03:2c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Sat, 21 Nov
 2020 06:48:48 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%6]) with mapi id 15.20.3564.035; Sat, 21 Nov 2020
 06:48:48 +0000
Subject: Re: [PATCH bpf-next v2 1/3] ima: Implement ima_inode_hash
To:     KP Singh <kpsingh@chromium.org>, James Morris <jmorris@namei.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
References: <20201121005054.3467947-1-kpsingh@chromium.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <e0df148d-3ba9-383f-237c-831d664c74c8@fb.com>
Date:   Fri, 20 Nov 2020 22:48:45 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
In-Reply-To: <20201121005054.3467947-1-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:b539]
X-ClientProxiedBy: MW4PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:303:8c::33) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::1688] (2620:10d:c090:400::5:b539) by MW4PR03CA0148.namprd03.prod.outlook.com (2603:10b6:303:8c::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Sat, 21 Nov 2020 06:48:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd22d320-28df-46c6-c50a-08d88de97f88
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4204:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4204F68AD380F10EF592143ED3FE0@SJ0PR15MB4204.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pegxF9/KWEGn8GrbqAesh8ch1SmLH8yI5XlxDtWyichwz3Yy7Xye9Xq+ZxLg8m8dEX0w+TZWP2Jvo+hPgV55cdPtX5DSZma4xNQKYJ0cWSvb7nc5pPuoFyqCDmft1X2tv31Vhu05zdR4QCJRz0uwP1044GFfEXfzwhGkSlP8QUiwyPYsoUzhCP6/cfqxo6P5YU9mDmoP67UGR6LeERQ0atTvuALVk4635+VfZQdFz/szVSy6ZBwqdWCt47RGRFcovA2E/w/C/SdJO8Opx+pBPlymNSW8Lu2ocnQvjYqQRaXPgHf3rzPvjCgZPDWm9cwR96XwKAVrW5okjEZEz08p2kMXYFtVJHWyA3xUmYCnSbMR/CTMS//YjfHpjWO4D/XY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(396003)(39860400002)(136003)(4744005)(2616005)(5660300002)(86362001)(83380400001)(31686004)(7416002)(2906002)(4326008)(478600001)(8676002)(8936002)(53546011)(16526019)(186003)(52116002)(6486002)(54906003)(110136005)(36756003)(316002)(66946007)(66556008)(66476007)(31696002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: dhpxvXjnb0tjo7llGW/nTUaQNVFCh51+5+TN18yfFFbzNRCIi1eANTYrzuncfM5fSZgflH+reRFInSHjLKzh3QnFVTit9tJt+1S/PdFvhtDRNvzxcQBelTrA58wMUAxXJEY2H2SYDYvPWXuWTPtPor598EZXffa28ED30DP7ALF1NcF0eOxG992jAJQ0XhVi8b2DxNoFwqXjSeHJE1pvcCiu/Zuyd0QBV7ufcgOOBvxLjBjaCcEO8rWz7DwfRhTrplBIar1RYolAosOsKua+9XB294ywXEO+MHd9/gOWCae0lNikmTwBGftOUxlTggTvCgpbnjXDNeqVAMFzmwFiP1U5O/sRP0/SIEh8gBfa7qv9RTLLQX/Io4P7oziZVZ67R7FS6qUT6NBOtLZNdRG94cbTDWpmDVq7JbvxEqL7wNulWRnOfh7coqGJSamKmq5oJB5YZT4mWXPikentJ8dUXGu1/pU89Z1gLjzU0g9T3mhh3B/BMD6JaDjUgQePTIn2S7ANX8d5XmrMl+DEdKlxkIN0WWLTVtwObzENjZCfJTK1lB1NxhcFIdjb1UYNAUkLz/oi3NYCWf8prChQKXDJb7Z80BTIejJ2DRvKlGL1/XxXym0yaZ/Bo5lAgsL1GLDX7LXTJ6IHgS39Ro/IeKBeM+IPD77Dyf70V9TqfvOhCIN8hv55pHr+68lY6zhPy1OLbmgGK3/+WvKfsTNCS34oLJukMjUsBlbrKgP97yDS76PFQwKRpI4d4AZA464mhFQoRRacI1EQf+fkQN8L7UjypInYBHqCXhgrRYblnPujunM4WRCSWog3/kNYGGxMQLegYWP6pee0HzeHPL+QVeWCOzH++UvpjQy7ija+KfRvOBPmm/vLrSPTqTbYC2gU97s6zfFt8vfeM0sCnK5u1lRgiQht8Ot6j32QlzI+BeQ+N1E=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd22d320-28df-46c6-c50a-08d88de97f88
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2020 06:48:48.4118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxI9Qq2KFR8HfOy/WJsEe7kQS0G0EH5dI1Ks+xFo0CKNWZEzAj3Pwj9Bm5j0alzG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4204
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-21_03:2020-11-20,2020-11-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=844
 mlxscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011210045
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/20/20 4:50 PM, KP Singh wrote:
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

Acked-by: Yonghong Song <yhs@fb.com>
