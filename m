Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D26417245D
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2020 18:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgB0RB2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Feb 2020 12:01:28 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36022 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729298AbgB0RB2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 Feb 2020 12:01:28 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RGtleh006959;
        Thu, 27 Feb 2020 09:01:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=xz1je/iD3uRYtzJrfFgQ1ruJsEJsNkK+PCZ97/C+IT4=;
 b=B5LBL8gIhK+WP7jQlWtWUqHWde6fHicEON1JPdE2NvynXEK3MPJR1E27w6KV/HZTnwA0
 UAH7/S991Pn4cKAyW1X/Bhm4dN/lbJxTOgt6Wg4BJjI4m069bSZ94c7NjwiGb1mtrzFz
 wizGLxsef5TKXnyRaFZ/9MJHecOeloXHSyU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2ydckyj23p-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 27 Feb 2020 09:01:12 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 27 Feb 2020 09:01:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMUqtZCsJ2Sydmw+OsJ1fOpX/ZRRZmyVipGqdSNaxKpDurBWFA18ByYmV7QDkWYSLNfq2nsSw3RyooQlTKFrlBBCcihyRin/RkPhtgrB9smJW/McgYmw42zuwfbni2E4DuPrxE/M08JsVxV5bhYxQfNNbZoOLJbqtLXS3Hs0rdXl05FEh1G+Iz4IBfMwC0xOJ5Vf065j/PrEEBY8lxu1AN9Qiw5JyLYcdZnsMoro4cfuqNSiPHg1o4gcbfRljjRXtm0DU9a/ci87FD87fe/TWSI5Tc6Dc9pzmcsbotBFNS2RSDqDdqsl1Eq3b6Y+4ZPKXq2oSvbDNj1mokAnIMSGjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xz1je/iD3uRYtzJrfFgQ1ruJsEJsNkK+PCZ97/C+IT4=;
 b=jsq4HRF7NaRrB35XGkcY/TVSGX3e7nj+tarQM7HhHZ1q4SBi0KlAp8X5J/OJL3QQlyUP8iU/ybeoM8PD2fbVKfUl+HQNOXgvDx5pK+OuZpb+CiemqejlfT13J3t3RJZ2YEGD/m0YLKTPxG+hoi+fcF1NgkPKkvW/2GRJLNYX9VT19FtguaD8fHbzCEs/pMxcyLy91WxTHXQ2V/1iaD2ZgVvthZVbNlm5o7DqlzfE9Q7EZb2ysAc6bS+7HdDFfqsrD2608pmYSEcjbqtwLt+TjbcA+KQQnZDBcNjqSXnUGrqYuync6W8h8ZR13OFuahYV3b5grHfIddbo9YOcEVfsUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xz1je/iD3uRYtzJrfFgQ1ruJsEJsNkK+PCZ97/C+IT4=;
 b=bNABUW76TgJ8KVLnOmTN2XQ2zrS2bTMue5ZG6eC13LzfNynHMurmHqnbQHukY1Cz8hLPIABmvLojm62AVILSNzh4STwDsNjQEazMlX7wbRvhylK3d4/y9bOhmslBCiasaCHpsDROBbWsbJzCupSIL7yLARhbqUG6R305+ukO7WU=
Received: from MWHPR15MB1294.namprd15.prod.outlook.com (2603:10b6:320:25::22)
 by MWHPR15MB1342.namprd15.prod.outlook.com (2603:10b6:320:22::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Thu, 27 Feb
 2020 17:01:05 +0000
Received: from MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::b47a:a4d2:b9dd:eb1e]) by MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::b47a:a4d2:b9dd:eb1e%5]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 17:01:05 +0000
Date:   Thu, 27 Feb 2020 09:01:03 -0800
From:   Andrey Ignatov <rdna@fb.com>
To:     Song Liu <songliubraving@fb.com>
CC:     bpf <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Omar Sandoval <osandov@fb.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] bpf: Add drgn script to list progs/maps
Message-ID: <20200227170103.GA29488@rdna-mbp>
References: <20200227023253.3445221-1-rdna@fb.com>
 <CE954665-BFCB-4E83-B20F-AECD12E180D2@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CE954665-BFCB-4E83-B20F-AECD12E180D2@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ClientProxiedBy: MWHPR22CA0005.namprd22.prod.outlook.com
 (2603:10b6:300:ef::15) To MWHPR15MB1294.namprd15.prod.outlook.com
 (2603:10b6:320:25::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2620:10d:c090:500::6:b3e7) by MWHPR22CA0005.namprd22.prod.outlook.com (2603:10b6:300:ef::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Thu, 27 Feb 2020 17:01:04 +0000
X-Originating-IP: [2620:10d:c090:500::6:b3e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21282817-e05b-43ee-12fe-08d7bba6a1ca
X-MS-TrafficTypeDiagnostic: MWHPR15MB1342:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR15MB13421848A46642CB4C751D7DA8EB0@MWHPR15MB1342.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(136003)(376002)(346002)(396003)(39860400002)(189003)(199004)(6486002)(81156014)(81166006)(66946007)(66556008)(66476007)(9686003)(8676002)(6636002)(2906002)(1076003)(478600001)(52116002)(16526019)(186003)(86362001)(5660300002)(33656002)(33716001)(4326008)(6862004)(6496006)(54906003)(316002)(53546011)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1342;H:MWHPR15MB1294.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UqgE1H3jAccUQx0NVbq4hYCCujp+VXaCRxyZqi26504vP1udpa87crzdIQOoofa0u5EwvSiZRKgLovwHP6Ec9kWlSecTbKiJPZyZca8TqyDwKR+3VnXTskKqrI+48BHtpJXNfqVlqPBwGEavJszFzte0TCRN58Pjyo7TkTidZ07JbomunZQZhTN1USTXpjWMU0FQ1JbFYUOWcWCdXYQW6cEI6aQBh4rFxiYmPMzs4VBdmBhxCIsWAafo2B3q6ytHbiYLu5cyGL2n6J0iaRzDf87VDUejA6o9MczDnz8SneynRWqFxPwgYMPZumKATWDbQhlruPBZleTuCXMwaQdDeUAz3P1RwYTV7j/K6rsjr30Rr6Ul8YdXtTuO7y5QIfM61N7yp/MdmP5aNKu52zDxy8sxTpbYbVeTKdJBKzR1Z4ObX0KW3IHzSbNopYvpvUAr
X-MS-Exchange-AntiSpam-MessageData: 80MVxImCKaKxlh1uQ1nrZXCVh8qVhdVdowXjAaNCumsGNgwRDXdqZ9rTM21Pt0HIKHT7sA3fkjoZho22vOkhM5XAnZx1/66hqagqdytG681ao0fjQQdCYoTYsZWGByFs8JzxIJ8izLkl0Gm+UMPNA21cbITyypke/4ioCaaiIs2BccdxvZKlEQaQDPccsPsi
X-MS-Exchange-CrossTenant-Network-Message-Id: 21282817-e05b-43ee-12fe-08d7bba6a1ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 17:01:05.3563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeH9R+6p44NgvJCzP6X15PlptamV1Ukt64T/6NaAzkLhMBlMD7rcyXTiX0OQmmvY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1342
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_05:2020-02-26,2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=645 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270126
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Song Liu <songliubraving@fb.com> [Wed, 2020-02-26 21:45 -0800]:
> 
> 
> > On Feb 26, 2020, at 6:32 PM, Andrey Ignatov <rdna@fb.com> wrote:
> > 
> > The main use-case bpf.py covers is to show BPF programs attached to
> > other BPF programs via freplace/fentry/fexit mechanisms introduced
> > recently. There is no user-space API to get this info and e.g. bpftool
> > can only show all BPF programs but can't show if program A replaces a
> > function in program B.
> 
> IIUC, bpftool misses features to show fireplace/fentry/fexit relations? 
> I think we should enable that in bpftool. 

No, the main part in the comment is "there is no user-space API", i.e.
to my best knowledge kernel currently can't provide this info, bpftool
was just an example of one of the most well known users of BPF API.

Specifically everything-trampoline or attach_prog_fd (or corresponding
prog id) / attach_btf_id passed at loading time are not available to
user-space.

I believe there will be many things like this that can be expensive to
expose to user space via proper kernel API but are still useful to see
in user space. That's the point of this drgn script.


> > 
> > The name bpf.py is not super authentic. I'm open to better options.
> 
> Maybe call it bpftool.py? Or bpfshow.py?

bpftool.py may cause confustion with the genuine bpftool so I'd avoid
it, but bpfshow.py looks fine.


-- 
Andrey Ignatov
