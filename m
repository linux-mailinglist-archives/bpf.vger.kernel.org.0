Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0512BB184
	for <lists+bpf@lfdr.de>; Fri, 20 Nov 2020 18:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbgKTRdw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Nov 2020 12:33:52 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51216 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728488AbgKTRdv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 20 Nov 2020 12:33:51 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AKHUR1Z032714;
        Fri, 20 Nov 2020 09:33:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=jVRVeLq3ru6/sIohM1eofCFIXigMEcNAZHhc3rjZx1k=;
 b=nZIZ5tA4TWHVE6zeYqYJP5B/h0Q78TdljZ19qqoFVLw2VFpZSUafYd2aGIgOwPGTfdUJ
 2jTvG5HD8/wfF6X3NZXsZ3ihad5SQF8ZEoLwhiraFYXL3v6/jse5+CsPERismj2168Yq
 GO2pJFgNUYVPacjNcyALND0zOAFdARkyhLs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34wx1spg7h-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 20 Nov 2020 09:33:10 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 20 Nov 2020 09:33:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdHf/QWxgI+RPTAklw96NQIK7Ehr2TIqSGPk7DTkOHuCRGECsd88oDRbdojeXYKIs3zQMW8lv6SMg1FikZJb3lxSti5cAYbT9YQKUc7FatqUhSPuoc8Zc/VV57CqoXdb+Te3ZNohYwoOJvkFATRYXAdxBnDKcLl0B8aIO3OaPiH5Dim/ULEX9PVizWK7IyelFfXi+dPiOzalo3TrE0TtteS4Zzw7HN5BfzFy2krB8v3qP7R+fP36K/aLGkYQCSMRo+CnMAfjfSm3+C942M1LfxGuPmKTpFBQTDHtywN6XraISOnhX2EHHFAXZaI4Y+W0ShaGOldKwHhlLjzTFTuURQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVRVeLq3ru6/sIohM1eofCFIXigMEcNAZHhc3rjZx1k=;
 b=eHXZ9lANhnzslcrxD3x5o7reNJ4BUsHyw2OYHN9tt3oxy7e3wR0GK4nN7Om1Ym8/LbDFX4LjDzlNS2pDsLvjT1BbrXX9aUCdXZYWlnGR3bETRSqnJuF/DWO/pWq/Dkz0/krAmFJKPYa/KAXajRdItkEOLfKx0oIjGQoBQN36arSpymfPwqedsxbmQnkk82lPZzSjWfum0f/r180+DJtJEMUTXZu4Da+ZUAonRhUVEPzOL0WIK3oCBWbY65VGF7VC19d77nhMpJIjRo3uI/h5JElWI2pI2YlE7V00kcymnKXD733B+AdwIGYDW9VPGDE085Ln/xc2cK1YzELRL6o/pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVRVeLq3ru6/sIohM1eofCFIXigMEcNAZHhc3rjZx1k=;
 b=VH4Y3lsU7S1LS4rwmXU+excFBMtGDsu9xSEREWqu/GfOJ8MLYJB0qH18+dma4LgLf75TCScp0plsyFK/dFpnllc9oew/yB5uUM4gVKqE/vEGwZrXE8FiP+8BBtSDGRvn7mAodNudNynfs5AOx7jOmhIk9AriUY2UkpMa7fbuabs=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB4087.namprd15.prod.outlook.com (2603:10b6:a02:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Fri, 20 Nov
 2020 17:32:54 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%6]) with mapi id 15.20.3564.028; Fri, 20 Nov 2020
 17:32:54 +0000
Subject: Re: [PATCH bpf-next 1/3] ima: Implement ima_inode_hash
To:     KP Singh <kpsingh@chromium.org>, James Morris <jmorris@namei.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
References: <20201120131708.3237864-1-kpsingh@chromium.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <deea0ee7-85f4-1f3a-9737-1dba98aa8278@fb.com>
Date:   Fri, 20 Nov 2020 09:32:51 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
In-Reply-To: <20201120131708.3237864-1-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:f0a]
X-ClientProxiedBy: MWHPR18CA0051.namprd18.prod.outlook.com
 (2603:10b6:300:39::13) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::1688] (2620:10d:c090:400::5:f0a) by MWHPR18CA0051.namprd18.prod.outlook.com (2603:10b6:300:39::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21 via Frontend Transport; Fri, 20 Nov 2020 17:32:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 205c16fd-9fc1-4140-5875-08d88d7a5015
X-MS-TrafficTypeDiagnostic: BYAPR15MB4087:
X-Microsoft-Antispam-PRVS: <BYAPR15MB408761C1E16603471BFE0392D3FF0@BYAPR15MB4087.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uUUXcv5brH+flKJMPGF+FjCQxSkNRpdfAYPxpc9OC8UxrrNu1zmqYqte6V2YsOk1m7KePj2uXw2ZINHVZYoCgHM9gC108eHcsrYbQtKduTYwLRFzsPcXYdrwFPi6Cwx1VKCS/WFgUHoK1gq0cHB7fy9hHbwSYeDKqGBbi4+06d1lW8vSRRKKxXtTx3/3j3vznq8G1yyYvitn8PGq3bDdfuHl4Oc7dWgs20Xcz+Yag/wkgVLDLtL+zfEd8wFJCxyOxQ8/N2s/It04x4+z7IDNmNBk8GTdQk+YN5NPB30cvVciIYM9OXAksC48Sm5rtwSi9jmx4cpA/dTeprPEdhKqBIR8r57HTpNwodUj1TnJbXoZjb4Lu8RAC/zI9oF1T4uQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(346002)(39860400002)(396003)(86362001)(2906002)(53546011)(186003)(5660300002)(66476007)(31696002)(83380400001)(66946007)(66556008)(478600001)(8676002)(36756003)(16526019)(2616005)(4326008)(54906003)(8936002)(7416002)(110136005)(31686004)(316002)(6486002)(52116002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: an4cdsvTXWtrDowDUmV8usdw2n95wPxeRSF389Fwl1SmHglgl49zox93ifREoMHV144TnUJTLnpdpLpFzW9j23vxpnrd9osllOsF7g228JC1umVd2eHIFGjAVG496XRNlDO2pzINxqXV4i7kLVKLi2HDQy7tQxAQ1zGSm83ukKp/kYgzDICGnkZlW9482jjDbmif7gGq8EhzCZsl4EweAnxJWM/EjesjWAqUceKlrw6vwt7f5E1lZ2kNmuDsRK7DDo8LkodknkrSuo1smJBYW18lLTx3cboGcbJOJqcc5Mu9pE2UoFXsNd38vIl51JH5/GGGj2/AWSldDyuOJGoSVfJb/ay9msfmoIpQNdk6vmtp4Y1rgDxqZWV63UhaDItz7qhPc3r7w3Hm+otqtbGM5OZhjWuHxYPsJ4xUg+N5Bi2KdqZneaRVY8tZEHEDbW5m3x6yGJEzZvc2eOUAJVoSWFUQTK2W/67ixlY0FdtcKAqK59FaJdwO3CO7HCCC3r/7zmNWWEjavq4SPxrw+3WEuLPwajd1dxERmCrbXBky81pMM4im7CaiLQOKBptKa3xnLQ4PAinLU/Gi9sR6i03e3RMFG0xsZtkLXoF8CruEXE97bAzGI0yziyHnxodSYxj4Mp7RLZok2SleNvaKtkcVp8Zwe7sa/KdiI6lNM5CUuHyZ5mI2dIvnzMPK1getnqPhTG5jsILGncZsRD4IKtF8jzKVEV6IY6VuSFB2HaTWcJAeeng5U9FjsnaEAf/u1vSqHhZly2QCEW3BwmcTRRZwPVfbWZFv0dpCRTrL0+bXqSRyuCNebBJzjGh/Sxb9JFxbQdxZUCE70GCpmkR2Twr7NE4ekOtcuIFkYZT7S4Imc9N5itoM3KPK4qLnvpOVfEMFJlvanIfXHm6T8DRS3Gq2BIGYXvuQOOCZV+e3HkCcihA=
X-MS-Exchange-CrossTenant-Network-Message-Id: 205c16fd-9fc1-4140-5875-08d88d7a5015
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 17:32:54.3437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XeDYugf/OzKsLC1dxLEbfCjYnaMouwEIQZQtQ6SBQprmpSd1RJVSXupW1Q1qUJnt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4087
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-20_09:2020-11-20,2020-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011200120
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/20/20 5:17 AM, KP Singh wrote:
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
> ---
>   include/linux/ima.h               |  6 +++
>   scripts/bpf_helpers_doc.py        |  1 +
>   security/integrity/ima/ima_main.c | 74 ++++++++++++++++++++++---------
>   3 files changed, 59 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 8fa7bcfb2da2..7233a2751754 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -29,6 +29,7 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
>   			      enum kernel_read_file_id id);
>   extern void ima_post_path_mknod(struct dentry *dentry);
>   extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
> +extern int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size);
>   extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
>   
>   #ifdef CONFIG_IMA_KEXEC
> @@ -115,6 +116,11 @@ static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
>   	return -EOPNOTSUPP;
>   }
>   
> +static inline int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>   static inline void ima_kexec_cmdline(int kernel_fd, const void *buf, int size) {}
>   #endif /* CONFIG_IMA */
>   
> diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
> index c5bc947a70ad..add7fcb32dcd 100755
> --- a/scripts/bpf_helpers_doc.py
> +++ b/scripts/bpf_helpers_doc.py
> @@ -478,6 +478,7 @@ class PrinterHelpers(Printer):
>               'struct tcp_request_sock',
>               'struct udp6_sock',
>               'struct task_struct',
> +            'struct inode',

This change (bpf_helpers_doc.py) belongs to patch #2.

>               'struct path',
>               'struct btf_ptr',
>       }
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 2d1af8899cab..1dd2123b5b43 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -501,37 +501,17 @@ int ima_file_check(struct file *file, int mask)
>   }
>   EXPORT_SYMBOL_GPL(ima_file_check);
>   
> -/**
> - * ima_file_hash - return the stored measurement if a file has been hashed and
> - * is in the iint cache.
> - * @file: pointer to the file
> - * @buf: buffer in which to store the hash
> - * @buf_size: length of the buffer
> - *
> - * On success, return the hash algorithm (as defined in the enum hash_algo).
> - * If buf is not NULL, this function also outputs the hash into buf.
> - * If the hash is larger than buf_size, then only buf_size bytes will be copied.
> - * It generally just makes sense to pass a buffer capable of holding the largest
> - * possible hash: IMA_MAX_DIGEST_SIZE.
> - * The file hash returned is based on the entire file, including the appended
> - * signature.
> - *
> - * If IMA is disabled or if no measurement is available, return -EOPNOTSUPP.
> - * If the parameters are incorrect, return -EINVAL.
> - */
> -int ima_file_hash(struct file *file, char *buf, size_t buf_size)
> +static int __ima_inode_hash(struct inode *inode, char *buf, size_t buf_size)
>   {
> -	struct inode *inode;
>   	struct integrity_iint_cache *iint;
>   	int hash_algo;
>   
> -	if (!file)
> +	if (!inode)
>   		return -EINVAL;

Based on original code, for ima_file_hash(), inode cannot be NULL,
so I prefer to remove this change here and add !inode test in
ima_inode_hash.


>   
>   	if (!ima_policy_flag)
>   		return -EOPNOTSUPP;
>   
> -	inode = file_inode(file);
>   	iint = integrity_iint_find(inode);
>   	if (!iint)
>   		return -EOPNOTSUPP;
> @@ -558,8 +538,58 @@ int ima_file_hash(struct file *file, char *buf, size_t buf_size)
>   
>   	return hash_algo;
>   }
> +
> +/**
> + * ima_file_hash - return the stored measurement if a file has been hashed and
> + * is in the iint cache.
> + * @file: pointer to the file
> + * @buf: buffer in which to store the hash
> + * @buf_size: length of the buffer
> + *
> + * On success, return the hash algorithm (as defined in the enum hash_algo).
> + * If buf is not NULL, this function also outputs the hash into buf.
> + * If the hash is larger than buf_size, then only buf_size bytes will be copied.
> + * It generally just makes sense to pass a buffer capable of holding the largest
> + * possible hash: IMA_MAX_DIGEST_SIZE.
> + * The file hash returned is based on the entire file, including the appended
> + * signature.
> + *
> + * If IMA is disabled or if no measurement is available, return -EOPNOTSUPP.
> + * If the parameters are incorrect, return -EINVAL.
> + */
> +int ima_file_hash(struct file *file, char *buf, size_t buf_size)
> +{
> +	if (!file)
> +		return -EINVAL;
> +
> +	return __ima_inode_hash(file_inode(file), buf, buf_size);
> +}
>   EXPORT_SYMBOL_GPL(ima_file_hash);
>   
> +/**
> + * ima_inode_hash - return the stored measurement if the inode has been hashed
> + * and is in the iint cache.
> + * @inode: pointer to the inode
> + * @buf: buffer in which to store the hash
> + * @buf_size: length of the buffer
> + *
> + * On success, return the hash algorithm (as defined in the enum hash_algo).
> + * If buf is not NULL, this function also outputs the hash into buf.
> + * If the hash is larger than buf_size, then only buf_size bytes will be copied.
> + * It generally just makes sense to pass a buffer capable of holding the largest
> + * possible hash: IMA_MAX_DIGEST_SIZE.
> + * The hash returned is based on the entire contents, including the appended
> + * signature.
> + *
> + * If IMA is disabled or if no measurement is available, return -EOPNOTSUPP.
> + * If the parameters are incorrect, return -EINVAL.
> + */
> +int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size)
> +{

Add
	if (!inode)
		return -EINVAL;


> +	return __ima_inode_hash(inode, buf, buf_size);
> +}
> +EXPORT_SYMBOL_GPL(ima_inode_hash);
> +
>   /**
>    * ima_post_create_tmpfile - mark newly created tmpfile as new
>    * @file : newly created tmpfile
> 
